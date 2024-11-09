//
//  DetaySayfa.swift
//  Movies(ColectionView)
//
//  Created by Burak Köstekli on 26.11.2023.
//

import UIKit

class DetaySayfa: UIViewController {

    
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmFiyatLabel: UILabel!
    
    var film:Filmler? // Bize bir film objesi gönderilecek ve filmler class'ından olacak
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = film {
            filmImageView.image = UIImage(named: f.resim!)
            filmFiyatLabel.text = "\(f.fiyat!) ₺"
            navigationItem.title = f.ad
        }
    }
}
