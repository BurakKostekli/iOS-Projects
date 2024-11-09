//
//  ResultViewController.swift
//  BMI-Calculator-LayoutPractice
//
//  Created by Burak Köstekli on 8.08.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue                // Buradaki kisimlarda esitligin saginda optional olan degerleri force unwraplemiyoruz. Nedeni de mesela label icin kendisi
        adviceLabel.text = advice               // zaten optional bir deger bekliyor. Icerisi bos da olabilir dolu da, onun icin bir sorun yok. Zaten bmiLabel.text ogesine
        view.backgroundColor = color            // option ile basili tutup tiklarsak gorebiliriz bunu.
        // Buradaki view degerine ulasmak icin olusturulan VC yi dosya olan VC ye baglamak gerekir. O zaman en temeldeki view objesine direkt bu sekilde erisebiliriz.
    }
    
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)     // aslinda self keywordu gerekli degil cunku swift anliyor bu class icin dismiss oldugunu
    }                                                     // ama kalirsa kod daha clean oluyor
    
    
}

