//
//  Second ViewController.swift
//  segue
//
//  Created by Burak Köstekli on 8.11.2023.
//

import UIKit

class Second_ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = myName
    }
    
    

}
