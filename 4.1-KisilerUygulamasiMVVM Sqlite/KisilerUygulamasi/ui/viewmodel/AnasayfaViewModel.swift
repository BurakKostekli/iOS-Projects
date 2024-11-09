//
//  AnasayfaViewModel.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    init() {
        kisilerListesi = krepo.kisilerListesi
        kisileriYukle()
        veritabaniKopyala()
    }
    
    var krepo = KisilerDaoRepository()
    
    func sil(kisi_id:Int) {
        krepo.sil(kisi_id: kisi_id)
    }
    
    func ara(aramaKelimesi:String) {
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func kisileriYukle() {
        krepo.kisileriYukle()
    }
    
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "rehber1", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("rehber1.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var")
        } else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch {
                print("Veritabanı kopyalama hatası")
            }
        }
    }
}
