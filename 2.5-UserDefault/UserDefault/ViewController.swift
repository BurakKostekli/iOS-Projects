//
//  ViewController.swift
//  UserDefault
//
//  Created by Burak Köstekli on 29.11.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelSayac: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tanımlama
        let ud = UserDefaults.standard
        
        // Kayıt
        ud.setValue("Ahmet", forKey: "ad")
        ud.setValue(10, forKey: "yas")
        ud.setValue(1.5, forKey: "kesir")
        ud.setValue(true, forKey: "true")
        
        let liste = ["ali","ece"]
        ud.setValue(liste, forKey: "liste")
        
        let sehirler = ["16":"Bursa", "34":"İstanbul"] // Her ikisi de String olmalı Dict kaydederken
        ud.setValue(sehirler, forKey: "sehirler")
        
        // Silme
//        ud.removeObject(forKey: "ad")
        
        // Okuma
        let gelenAd = ud.string(forKey: "ad") ?? "isim yok" // Solda hata olursa sağdaki gelenAd'a aktarılıyor
        let gelenYas = ud.integer(forKey: "yas") // otomatik varsayılanı : 0
        let gelenKesir = ud.double(forKey: "kesir") // otomatik varsayılanı : 0.0
        let gelenSoru = ud.bool(forKey: "true") // otomatik varsayılanı : false
        
        let gelenListe = ud.array(forKey: "liste") ?? [String]()
        let gelenSehirler = ud.dictionary(forKey: "sehirler") ?? [String:String]()
        
        
        // Sayaç
        var sayac = ud.integer(forKey: "sayac") // Varsayılanı zaten 0
        
        sayac += 1
        
        ud.setValue(sayac, forKey: "sayac")
        
        labelSayac.text = "Açılış Sayısı: \(sayac)"
        
        
        
        
    }


}

