//
//  AnasayfaViewModel.swift
//  Movies(ColectionView)
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var frepo = FilmlerDaoRepository()
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]())
    
    init() { // Anasayfa viewModel türünde bir nesne oluşturulduğu anda çalışacak kodlar
        veritabaniKopyala()
        filmlerListesi = frepo.filmlerListesi
        filmleriYukle()
    }
    
    func filmleriYukle() {
        frepo.filmleriYukle()
    }
    
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "filmler_app", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler_app.sqlite")
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var")
        } else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch {
                print("SQLite hatası")
            }
        }
    }
    
}
