//
//  ObjectViewController.swift
//  Avsw_test
//
//  Created by Владислав on 19.10.2020.
//

import Foundation
import UIKit
import CoreData

class ObjectViewController: UIViewController {
    
    @IBOutlet weak var objectsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        objectsTableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CoreData
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
    
    func deleteData(_ object: NSManagedObject, at indexPath: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(object)
        ObjectsInfo.shared.objects.remove(at: indexPath)
    }

}

    // MARK: - TableView
extension ObjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectsInfo.shared.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell" , for: indexPath) as! ObjectCell
        
        let object = ObjectsInfo.shared.objects[indexPath.row]//ObjectsInfo.shared.objects[indexPath.row]
        
        let nameCell = object.value(forKey:"name") as? String
        let surnameCell = object.value(forKey:"surname") as? String
        let optionalCell = object.value(forKey:"optional") as? String
        cell.nameLabel.text =  "ФИО: " + surnameCell! + " " + nameCell!
        cell.optionalLabel.text = "Атрибуты: " + optionalCell!
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить"){ _,_  in
            
            self.deleteData(ObjectsInfo.shared.objects[indexPath.row], at: indexPath.row)
            self.objectsTableView.reloadData()
        }
        let action = [deleteAction]
        return action
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
        modalViewController?.modalPresentationStyle = .fullScreen
        if let vc = modalViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
        ObjectsInfo.shared.objectsEdit = ObjectsInfo.shared.objects[indexPath.row]
        ObjectsInfo.shared.objectsEditIndex = indexPath.row
    
    }
}
