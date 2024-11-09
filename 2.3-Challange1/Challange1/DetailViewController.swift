//
//  ViewController.swift
//  Challange1
//
//  Created by Burak Köstekli on 29.12.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage:String?
    var imageName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = capitalizeFirstLetter(imageName!)
        navigationItem.largeTitleDisplayMode = .never
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    
    func capitalizeFirstLetter(_ str: String) -> String {
        return str.prefix(1).capitalized + str.dropFirst()
    }
    // Bu fonksiyon, prefix(1) ile stringin ilk karakterini alır, capitalized ile büyük harfe dönüştürür ve dropFirst() ile geri kalan kısmı ekler. Bu şekilde sadece ilk harfi büyük olan bir string elde edilir.

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else
        {
            print("No Image Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageName!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

