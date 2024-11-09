//
//  DetailsVC.swift
//  ArtBook
//
//  Created by Burak Köstekli on 11.11.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if chosenPainting != "" {
            
            saveButton.isEnabled = false // isHidden'da yapabiliriz ve tamamen görünmez olur
            
            // Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            // Çekme işleminden önce filtreleme yapacağız
            let idString = chosenPaintingId?.uuidString // Stringe dönüştüren metod uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!) // id'si şu olanı seç demek
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            } catch {
                print("Error")
            }
        } 
        
        else {
            saveButton.isEnabled = false
        }
        
        
        
        // RECOGNIZERS-----------------------
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    // OBJC-----------------------
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true // Kullanıcı seçtiği görseli editleyebilir, istediği kısmı croplar mesela
        present(picker, animated: true, completion: nil) // Burada da alert'ları vs gösterdiğimiz gibi bunu da
    }
    
    // didFinishPickingMediaWithInfo yazıp enter :
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true // Ekledik buraya
        self.dismiss(animated: true, completion: nil) // Açtığımız picker'ı kapatmak için kod
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // insertNewObject ile yeni bir obje koyuyoruz ve entity adını ve bunu kaydedebileceği bir context istiyor ki yukarıda oluşturduk
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        // Attributes (burada key kısmının daha önceden belirttiklerimizin aynısı olması gerek)
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        
        // burada bizden Int istiyor CoreData ve Int'e dönebilirse diyerek yaptık uygulama çökmesin diye
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id") // Tüm değişkenler kaydedilince hepsine ID ataması yapar
        
        
        // Şimdi görseli kaydedeceğiz ve kaydederken data'ya çevireceğiz :
        // Bu fonksiyon boyutu küçülterek dataya çeviriyor :
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5) // ne kadarı sıkıştırılsın seçtik
        
        newPainting.setValue(data, forKey: "image")
        
        // Final
        do {
            try context.save()
            print("Success")
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    

}
