//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Burak Köstekli on 10.08.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var calculatedMoney: String?
    var settings: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = calculatedMoney
        settingsLabel.text = settings
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
