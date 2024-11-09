//
//  ViewController.swift
//  layout2
//
//  Created by Burak Köstekli on 7.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldBirthday: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelBirthday: UILabel!
    
    // DATABASE AND DISPLAY
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if let newName = storedName as? String {
            labelName.text = "Name: \(newName)"
        }
        
        if let newBirthday = storedBirthday as? String {
            labelBirthday.text = "Birthday: \(newBirthday)"
        }
    }
    
    // DISPLAY AND SAVE
    @IBAction func buttonSave(_ sender: Any) {
        // Database'e kaydetme
        UserDefaults.standard.set(textFieldName.text!, forKey: "name")
        UserDefaults.standard.set(textFieldBirthday.text!, forKey: "birthday")
        
        // Ekrana yazdırma
        labelName.text = "Name: \(textFieldName.text!)"
        labelBirthday.text = "Birthday: \(textFieldBirthday.text!)"
    }
    
    // DELETE
    @IBAction func buttonDelete(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
//        if let newName = storedName as? String {
//            UserDefaults.standard.removeObject(forKey: "name")
//        }
//        if let newbirthday = storedBirthday as? String {
//            UserDefaults.standard.removeObject(forKey: "birthday")
//        }
        
        // Aslında yukarıdaki gibi de yapabilirdik ama daha iyi bir yolu var :
        
        if (storedName as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            // labelName.text = "Name:"
        }
        
        if (storedBirthday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "birthday")
            // labelBirthday.text = "Birthday:"
        }
    }
    
}

