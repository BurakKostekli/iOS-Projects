//
//  ViewController.swift
//  Contactss
//
//  Created by Burak Köstekli on 24.11.2023.
//

import UIKit
import CoreData

class MainPage: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var selectedName = ""
    var selectedID: UUID?
    
    var nameArray = [String]()
    var numberArray = [String]()
    var idArray = [UUID]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        self.navigationItem.title = "Contact"
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
        self.tableView.reloadData()
    }
    
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        selectedName = ""
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    
    
    // GET DATA
    @objc func getData() {
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        numberArray.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let number = result.value(forKey: "number") as? String {
                        self.numberArray.append(number)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                }
                tableView.reloadData()
            }
        } catch {
            print("Get CoreData Error")
        }
    }
}



extension MainPage: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


extension MainPage: UITableViewDelegate, UITableViewDataSource {
    
    // DATA TRANSFER
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = nameArray[indexPath.row]
        selectedID = idArray[indexPath.row]
        performSegue(withIdentifier: "toAdd", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            let destinationVC = segue.destination as! NewPersonVC
            destinationVC.chosenName = selectedName
            destinationVC.chosenID = selectedID
        }
    }
    
    
    
    // TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = nameArray[indexPath.row]
        content.secondaryText = numberArray[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    // TableView Commit (DELETE)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
//            let idString = idArray[indexPath.row].uuidString
//            
//            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
//            fetchRequest.returnsObjectsAsFaults = false
//            
//            do {
//                let results = try context.fetch(fetchRequest)
//                
//                if results.count > 0 {
//                    for result in results as! [NSManagedObject] {
//                        if let id = result.value(forKey: "id") as? UUID {
//                            
//                            if id  == idArray[indexPath.row] {
//                                context.delete(result)
//                                nameArray.remove(at: indexPath.row)
//                                idArray.remove(at: indexPath.row)
//                                self.tableView.reloadData()
//                                
//                                do {
//                                    try context.save()
//                                } catch {
//                                    print("Error new Save")
//                                }
//                                break
//                            }
//                        }
//                    }
//                }
//            } catch {
//                print("Error Save")
//                
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {contextualAction,view,bool in
            
            let alert = UIAlertController(title: "Delete", message: "Delete \(self.nameArray[indexPath.row])?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
                let idString = self.idArray[indexPath.row].uuidString
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let id = result.value(forKey: "id") as? UUID {
                                
                                if id  == self.idArray[indexPath.row] {
                                    context.delete(result)
                                    self.nameArray.remove(at: indexPath.row)
                                    self.idArray.remove(at: indexPath.row)
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Error new Save")
                                    }
                                    break
                                }
                            }
                        }
                    }
                } catch {
                    print("Error Save")
                    
                }
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        
    return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
