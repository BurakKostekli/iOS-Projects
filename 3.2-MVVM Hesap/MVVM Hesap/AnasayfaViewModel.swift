//
//  AnasayfaViewModel.swift
//  MVVM Hesap
//
//  Created by Burak Köstekli on 27.11.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var sonuc = BehaviorSubject<String>(value: "0")
    var mrepo = MatematikRepository()
    
    init(){
        sonuc = mrepo.sonuc
    }
    
    func toplamaYap(alinanSayi1:String, alinanSayi2:String) {
        mrepo.toplamaYap(alinanSayi1: alinanSayi1, alinanSayi2: alinanSayi2)
    }
    
    func cikarmaYap(alinanSayi1:String, alinanSayi2:String) {
        mrepo.cikarmaYap(alinanSayi1: alinanSayi1, alinanSayi2: alinanSayi2)
    }
}

