//
//  ViewController.swift
//  AlertProject
//
//  Created by Burak Köstekli on 9.11.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var password2Text: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        
        func alertF (title : String, message : String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if usernameText.text == "" {
            alertF(title: "Error", message: "Username not found!")
        }
        else if passwordText.text == "" {
            alertF(title: "Error", message: "Password not found!")
        }
        else if passwordText.text != password2Text.text {
            alertF(title: "Error", message: "Passwords do not match")
        }
        else {
            let alert = UIAlertController(title: "Success", message: "User Ok", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
                // Button Clicked
                self.performSegue(withIdentifier: "toSecondVC", sender: nil)
            }
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        }
    }


}

