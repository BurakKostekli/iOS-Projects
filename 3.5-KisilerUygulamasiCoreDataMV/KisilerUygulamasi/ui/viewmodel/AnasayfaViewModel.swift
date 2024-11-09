//
//  AnasayfaViewModel.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var krepo = KisilerDaoRepository()
    var kisilerListesi = BehaviorSubject<[KisilerModel]>(value: [KisilerModel]())
    
    init() { // Anasayfa ViewModel'den bir nesne oluşunca çalışacak
        kisilerListesi = krepo.kisilerListesi
        kisileriYukle()
    }
    
    func sil(kisi:KisilerModel) {
        krepo.sil(kisi: kisi)
    }
    
    func ara(aramaKelimesi:String) {
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func kisileriYukle() {
        krepo.kisileriYukle()
    }
    
}
