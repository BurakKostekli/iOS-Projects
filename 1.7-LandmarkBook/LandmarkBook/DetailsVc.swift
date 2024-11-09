//
//  DetailsVc.swift
//  LandmarkBook
//
//  Created by Burak Köstekli on 10.11.2023.
//

import UIKit

class DetailsVc: UIViewController {
    
    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLandmarkName = ""
    var selectedLandmarkImage = UIImage() // Diğer VC'den bir seçim yapıldığında bu iki değişkene etki etsin istiyoruz.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkLabel.text = selectedLandmarkName
        imageView.image = selectedLandmarkImage
    }
    


}
