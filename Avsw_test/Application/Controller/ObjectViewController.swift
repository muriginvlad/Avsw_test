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
    
//    var contacts: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
   //     fetch()
        objectsTableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
//    func fetch() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedObjectContext = appDelegate.persistentContainer.viewContext as! NSManagedObjectContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ObjectsDatas")
//        do {
//            contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch. \(error)")
//        }
//    }
//
//    func save(name: String, surname: String,optional: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        guard let entity = NSEntityDescription.entity(forEntityName:"ObjectsDatas", in: managedObjectContext) else { return }
//        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
//        contact.setValue(name, forKey: "name")
//        contact.setValue(surname, forKey: "surname")
//        contact.setValue(optional, forKey: "optional")
//        do {
//            try managedObjectContext.save()
//            self.contacts.append(contact)
//        } catch let error as NSError {
//            print("Couldn't save. \(error)")
//        }
//    }

//    func update(indexPath: IndexPath, name:String, phoneNumber: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        let contact = contacts[indexPath.row]
//        contact.setValue(name, forKey:"name")
//        contact.setValue(phoneNumber, forKey: "phoneNumber")
//        do {
//            try managedObjectContext.save()
//            contacts[indexPath.row] = contact
//        } catch let error as NSError {
//            print("Couldn't update. \(error)")
//        }
//    }
//
//    func delete(_ contact: NSManagedObject, at indexPath: IndexPath) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        managedObjectContext.delete(contact)
//        contacts.remove(at: indexPath.row)
//    }

}

extension ObjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectsInfo.shared.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell" , for: indexPath) as! ObjectCell
        let object = ObjectsInfo.shared.objects[indexPath.row]
        cell.nameLabel.text = "ФИО: " + object.surname + " " + object.name
        cell.optionalLabel.text = "Атрибуты: " + object.optional
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editingRow = ObjectsInfo.shared.objects[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить"){ _,_  in
            ObjectsInfo.shared.objects.remove(at: indexPath.row)
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
