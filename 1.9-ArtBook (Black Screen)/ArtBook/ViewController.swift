//
//  ViewController.swift
//  ArtBook
//
//  Created by Burak Köstekli on 11.11.2023.
//
// Halen kayıtlı kısıma girildiğinde resime ve textfield'lara tıklanıyor ve değiştirilebiliyor fixle

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPainting = ""
    var selectedPaintingId: UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func getData() {
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false // Bu birazcık optimize ediyor bunu araştır (çok büyük kaydetmeler oluyorsa mühim ama küçük data setlerinde önemli değil)
        
        do {
            let results = try context.fetch(fetchRequest) // result diye değere atadık ve gelecek diziyi almış olduk (any dizisi)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    self.tableView.reloadData() // TableView güncelle
                    
                }
            }
            
        } catch {
            print("error")
        }
    }

    @objc func addButtonClicked() {
        selectedPainting = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // TABLEVİEW FUNCS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        
        content.text = nameArray[indexPath.row]
        
        cell.contentConfiguration = content
        return cell
    }
    
    // VERİ AKTARIMI
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    // tableViewcommit
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = idArray[indexPath.row].uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString) // Nereye tıklandıysa onun id'sini bulmuş olduk
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results  = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row]  {         // Silme işlemi olduğu için iyice emin olmak istiyoruz
                                context.delete(result)                 // Yoksa zaten eşit olmak zorunda, ama olur da iki tane vs
                                nameArray.remove(at: indexPath.row)    // verirse diye. Ardından CoreData ve array'lerdeki verileri gg
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()            // Bu işlemler bitince de save edip coreData ile yapılan
                                                                       // işlemleri bitirmek istiyoruz context.save() ile (do try ile)
                                do {
                                    try context.save()
                                } catch {
                                    print("error3")
                                }
                                
                                break
                            }
                        }
                    }
                }
                
            } catch {
                print("error2")
            }
            
            
        }
    }

}

