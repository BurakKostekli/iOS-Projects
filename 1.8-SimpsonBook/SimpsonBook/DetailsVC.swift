//
//  DetailsVC.swift
//  SimpsonBook
//
//  Created by Burak Köstekli on 11.11.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    var selectedSimpson : Simpsons?
    // Bir simpson objesi oluşturduk. initialize olmadığı için () koymayı denedik fakat o şekilde de koyamayız içeriğine name vs girmemizi isteyecek. O yüzden ? koyduk.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedSimpson?.name // Burada da optional yazmamız lazım artık tabi.
        jobLabel.text = selectedSimpson?.job
//        imageView.image = selectedSimpson?.image
        
    }
    
}
