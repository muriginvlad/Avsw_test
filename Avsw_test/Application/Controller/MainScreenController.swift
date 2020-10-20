//
//  MainScreenController.swift
//  Avsw_test
//
//  Created by Владислав on 16.10.2020.
//

import Foundation
import UIKit
import CoreData

class MainScreenController: UIViewController {
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var optionalTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var menuVC: MenuViewController!
    var titleText = "Заполните форму"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuVC = self.storyboard?.instantiateViewController(identifier:"MenuViewController") as! MenuViewController
        startSetting()
    }
    
    func startSetting() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        titleLabel.text = titleText
        fetch()
        if let object = ObjectsInfo.shared.objectsEdit {
            
            nameTextField.text = object.value(forKey:"name") as! String
            surnameTextField.text = object.value(forKey:"surname") as! String
            optionalTextField.text = object.value(forKey:"optional") as! String
            titleLabel.text = "Измените данные"
            ObjectsInfo.shared.objectsEdit = nil
        }
    }
    

    
    @IBAction func menuBarButtonItem(_ sender: UIBarButtonItem) {
        if AppDelegate.isMenuVC {
            showMenu()
        }else {
            hideMenu()
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if nameTextField.text?.isEmpty ?? true {
            stateLabel.text = "Введите имя"
        } else if surnameTextField.text?.isEmpty ?? true{
            stateLabel.text = "Введите фамилию"
        } else if surnameTextField.text?.isEmpty ?? true && nameTextField.text?.isEmpty ?? true  {
            stateLabel.text = "Введите имя и фамилию"
        } else {
            
            let name = nameTextField.text
            let surname = surnameTextField.text
            let optional = optionalTextField.text
            let object = ObjectsData(name: name!, surname: surname!, optional: optional!)
            
            if ObjectsInfo.shared.objectsEditIndex != nil {
                updateData(indexPath: ObjectsInfo.shared.objectsEditIndex!, name: object.name, surname: object.surname,optional: object.optional)
                ObjectsInfo.shared.objectsEditIndex = nil
            } else {
               saveData(name: object.name, surname: object.surname,optional: object.optional)
            }
            
            
            stateLabel.text = "Контакт сохранен"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.stateLabel.text = ""
            })
            
            nameTextField.text?.removeAll()
            surnameTextField.text?.removeAll()
            optionalTextField.text?.removeAll()
        }
    }
    
    // MARK: - CoreData
    func saveData(name: String, surname: String,optional: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ObjectsDatas", in: managedObjectContext) else { return }
        let object = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        object.setValue(name, forKey: "name")
        object.setValue(surname, forKey: "surname")
        object.setValue(optional, forKey: "optional")
        do {
            try managedObjectContext.save()
            ObjectsInfo.shared.objects.append(object)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }

        func updateData(indexPath: Int, name: String, surname: String,optional: String) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let object = ObjectsInfo.shared.objects[indexPath]
            object.setValue(name, forKey: "name")
            object.setValue(surname, forKey: "surname")
            object.setValue(optional, forKey: "optional")
            do {
                try managedObjectContext.save()
                
                ObjectsInfo.shared.objects.insert(object, at: indexPath)
            } catch let error as NSError {
                print("Couldn't update. \(error)")
            }
        }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext as! NSManagedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ObjectsDatas")
        do {
            ObjectsInfo.shared.objects = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }

    // MARK: - Меню
    
    func showMenu(){
        UIView.animate(withDuration: 0.3) {
            self.menuVC.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.isMenuVC = false
            
        }
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            showMenu()
        case .left:
            hideMenu()
        default: break
        }
    }
    
    
}



