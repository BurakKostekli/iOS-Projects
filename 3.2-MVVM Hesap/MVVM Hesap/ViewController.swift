//
//  ViewController.swift
//  MVVM Hesap
//
//  Created by Burak Köstekli on 27.11.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelSonuc: UILabel!
    @IBOutlet weak var tfSayi1: UITextField!
    @IBOutlet weak var tfSayi2: UITextField!
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = viewModel.sonuc.subscribe(onNext: { s in // Observe (dinleme)
            self.labelSonuc.text = s
        })
        
    }
    @IBAction func toplama(_ sender: Any) {
        if let alinanSayi1 = tfSayi1.text, let alinanSayi2 = tfSayi2.text {
            viewModel.toplamaYap(alinanSayi1: alinanSayi1, alinanSayi2: alinanSayi2)
        }
    }
    
    @IBAction func cikarma(_ sender: Any) {
        if let alinanSayi1 = tfSayi1.text, let alinanSayi2 = tfSayi2.text {
            viewModel.cikarmaYap(alinanSayi1: alinanSayi1, alinanSayi2: alinanSayi2)
        }
    }
    
}

