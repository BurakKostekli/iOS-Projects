//
//  ViewController.swift
//  segue
//
//  Created by Burak Köstekli on 8.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var userName = ""
    
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad function called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear function called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear function called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear function called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear function called")
    }

    @IBAction func buttonClicked(_ sender: Any) {
        userName = nameText.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Hangi segue'yi kullanacağımızı kontrole edelim ki başak butona basınca yine diğer sayfaya geçerse bu işlemleri yapmasın
        if segue.identifier == "toSecondVC" {
            // casting
            let destinationVC = segue.destination as! Second_ViewController
            
            destinationVC.myName = userName
        }
    }
    
    
}

