//
//  ViewController.swift
//  Products
//
//  Created by Burak Köstekli on 25.11.2023.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var urunlerTableView: UITableView!
    var urunlerArray = [Urunler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urunlerTableView.delegate = self
        urunlerTableView.dataSource = self
        
        let u1 = Urunler(id: 1, ad: "Macbook Pro 14", resim: "bilgisayar", fiyat: 43000)
        let u2 = Urunler(id: 2, ad: "Rayban Club Master", resim: "gozluk", fiyat: 2500)
        let u3 = Urunler(id: 3, ad: "Sony ZX Series", resim: "kulaklik", fiyat: 40000)
        let u4 = Urunler(id: 4, ad: "Gio Armani", resim: "parfum", fiyat: 2000)
        let u5 = Urunler(id: 5, ad: "Casio X Series", resim: "saat", fiyat: 8000)
        let u6 = Urunler(id: 6, ad: "Dyson V8", resim: "supurge", fiyat: 18000)
        let u7 = Urunler(id: 7, ad: "Iphone 13 128GB", resim: "telefon", fiyat: 36999)
        urunlerArray.append(u1)
        urunlerArray.append(u2)
        urunlerArray.append(u3)
        urunlerArray.append(u4)
        urunlerArray.append(u5)
        urunlerArray.append(u6)
        urunlerArray.append(u7)
        
        urunlerTableView.separatorColor = UIColor(white: 0.95, alpha: 1) // Arkaplanla aynı renk = görünmez
    }
}



extension Anasayfa : UITableViewDelegate, UITableViewDataSource, HucreProtocol {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urunlerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urun = urunlerArray[indexPath.row]
        
        // Buradan cell için oluşturdupumuz class'a ulaşmamız gerekiyor ki buradaki bilgileri oradaki resme, isme vs koyalım
        let hucre = tableView.dequeueReusableCell(withIdentifier: "urunlerHucre") as! UrunlerHucre
        hucre.imageViewUrun.image = UIImage(named: urun.resim!)
        hucre.labelUrunAd.text = urun.ad
        hucre.labelUrunFiyat.text = "\(urun.fiyat!) ₺"
        
        hucre.backgroundColor = UIColor(white: 0.95, alpha: 1) // Alfa = görünürlük, burada gri bir ton yakaladık pratik olarak
        hucre.hucreArkaplan.layer.cornerRadius = 10.0 // View'in köşeleri kıvırdık
        
        hucre.hucreProtocol = self
        hucre.indexPath = indexPath
        
        return hucre
    }
    
    // TrailingSwipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let urun = urunlerArray[indexPath.row] // Hangi ürün olduğunu bilmemiz için gerekiyor
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction,view,bool in
            print("\(urun.ad!) deleted")
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { contextualAction,view,bool in
            print("\(urun.ad!) edited")
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urun = urunlerArray[indexPath.row]
        urunlerTableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "toDetay", sender: urun)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let urun = sender as? Urunler { // sender Any? şeklinde alındığı için casting
                let destinationVC = segue.destination as! DetaySayfa
                destinationVC.urun = urun
            }
        }
    }
    
    func sepeteEkleTiklandi(indexPath: IndexPath) {
        let urun = urunlerArray[indexPath.row]
        print("\(urun.ad!) sepete eklendi")
    }
}

