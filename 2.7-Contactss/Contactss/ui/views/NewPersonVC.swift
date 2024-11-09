//
//  NewPersonVC.swift
//  Contactss
//
//  Created by Burak Köstekli on 24.11.2023.
//

import UIKit
import CoreData

class NewPersonVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tfPersonName: UITextField!
    @IBOutlet weak var tfPersonNumber: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var chosenName = ""
    var chosenID: UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if chosenName != "" {
            
            navigationItem.title = "Person"
            saveButtonOutlet.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            
            // Filtreleme
            let idString = chosenID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            tfPersonName.text = name
                        }
                        if let number = result.value(forKey: "number") as? String {
                            tfPersonNumber.text = number
                        }
                            
                    }
                }
            } catch {
                print("Error Last")
            }
        } else { // +
            saveButtonOutlet.isHidden = false
        }
    }
    
    

    @IBAction func buttonSave(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: context)
        
        newContact.setValue(tfPersonName.text!, forKey: "name")
        newContact.setValue(tfPersonNumber.text!, forKey: "number")
        newContact.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
        } catch {
            print("CoreData Save Error")
        }
        
        // NavCenter
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
    

}
