//
//  MainScreenController.swift
//  Avsw_test
//
//  Created by Владислав on 16.10.2020.
//

import Foundation
import UIKit

class MainScreenController: UIViewController {
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var optionalTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var menuVC: MenuViewController!
    var titleText = "Заполните форму"
    var edditObjects: ObjectsData? = nil
    var indexPathObjects: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuVC = self.storyboard?.instantiateViewController(identifier:"MenuViewController") as! MenuViewController
        startSettingMenu()
    }
    
    func startSettingMenu() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        stateLabel.text = ""
        titleLabel.text = titleText
        
        if let edditObjects = ObjectsInfo.shared.objectsEdit {
            nameTextField.text = edditObjects.name
            surnameTextField.text = edditObjects.surname
            optionalTextField.text = edditObjects.optional
            titleText = "Измените данные"
            ObjectsInfo.shared.objectsEdit = nil
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
                ObjectsInfo.shared.objects[ObjectsInfo.shared.objectsEditIndex!] = object
                ObjectsInfo.shared.objectsEditIndex = nil
            } else {
                ObjectsInfo.shared.objects.append(object)
            }
            
            stateLabel.text = "Контакт сохранен"
            
            nameTextField.text?.removeAll()
            surnameTextField.text?.removeAll()
            optionalTextField.text?.removeAll()
            
            

        }
    }
    
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
    
    
}



