//
//  ViewController.swift
//  FirstApp
//
//  Created by Burak Köstekli on 6.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func changeClicked(_ sender: Any) {
        imageView.image = UIImage(named: "pxfuel2")
    }
    
}

