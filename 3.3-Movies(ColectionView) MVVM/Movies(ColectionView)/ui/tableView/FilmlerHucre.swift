//
//  FilmlerHucre.swift
//  Movies(ColectionView)
//
//  Created by Burak Köstekli on 26.11.2023.
//



import UIKit


protocol HucreProtocol {
    func sepeteEkleClicked(indexPath:IndexPath)
}


class FilmlerHucre: UICollectionViewCell {
    
    @IBOutlet weak var labelFiyat: UILabel!
    @IBOutlet weak var imageViewFilm: UIImageView!
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        hucreProtocol?.sepeteEkleClicked(indexPath: indexPath!)
    }
    
}
