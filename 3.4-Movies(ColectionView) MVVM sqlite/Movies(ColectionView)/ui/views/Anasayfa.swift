//
//  ViewController.swift
//  Movies(ColectionView)
//
//  Created by Burak Köstekli on 26.11.2023.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var filmlerCollectionView: UICollectionView!
    var filmlerListesi = [Filmler]()
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmlerCollectionView.delegate = self
        filmlerCollectionView.dataSource = self
        
        _ = viewModel.filmlerListesi.subscribe(onNext: { liste in
            self.filmlerListesi = liste
            self.filmlerCollectionView.reloadData()
        })
        
        //CollectionView Desing
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        // 10x10x10  x'ler cell diğerleri yazdığımız kodlara göre gelen boşluklar
        let ekranGenislik = UIScreen.main.bounds.width // Bulunduğumuz ekranın genişliği
        let itemGenislik = (ekranGenislik - 30) / 2 // 3'e bölmek istesek ona göre hesaplardık
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.7)
        filmlerCollectionView.collectionViewLayout = tasarim
    }
}


extension Anasayfa : UICollectionViewDelegate, UICollectionViewDataSource, HucreProtocol {
    
    // numberOfItems
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmlerListesi[indexPath.row]
        
        // Hücre dosyasına değer aktaracağız                                cell id :
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "filmlerHucre", for: indexPath) as! FilmlerHucre
        hucre.imageViewFilm.image = UIImage(named: film.resim!)
        hucre.labelFiyat.text = "\(film.fiyat!) ₺"
        
        // Stillendirme
        hucre.layer.borderColor = UIColor.lightGray.cgColor // Bu şekilde renk verince cgColor da gerekiyor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        
        hucre.hucreProtocol = self
        hucre.indexPath = indexPath
        
        return hucre
    }
    
    
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        
        performSegue(withIdentifier: "toDetay", sender: film)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let film = sender as? Filmler {
                let destinationVC = segue.destination as! DetaySayfa
                destinationVC.film = film
            }
        }
    }
    
    
    
    func sepeteEkleClicked(indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        print("Film eklendi: \(film.ad!)")
    }
}
