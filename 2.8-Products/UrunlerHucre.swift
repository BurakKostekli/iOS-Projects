//
//  UrunlerHucre.swift
//  Products
//
//  Created by Burak Köstekli on 25.11.2023.
//

import UIKit

protocol HucreProtocol { // Ayrı bir dosya olarakta oluşturulabilirdi
    func sepeteEkleTiklandi(indexPath:IndexPath)
}

class UrunlerHucre: UITableViewCell {

    @IBOutlet weak var hucreArkaplan: UIView!
    @IBOutlet weak var imageViewUrun: UIImageView!
    @IBOutlet weak var labelUrunAd: UILabel!
    @IBOutlet weak var labelUrunFiyat: UILabel!
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func butonSepeteEkle(_ sender: Any) {
        hucreProtocol?.sepeteEkleTiklandi(indexPath: indexPath!)
    }
    
}
