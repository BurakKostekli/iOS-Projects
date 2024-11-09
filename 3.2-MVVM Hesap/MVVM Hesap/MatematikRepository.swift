//
//  MatematikRepository.swift
//  MVVM Hesap
//
//  Created by Burak Köstekli on 27.11.2023.
//

import Foundation
import RxSwift

class MatematikRepository {
    var sonuc = BehaviorSubject<String>(value: "0")
    
    func toplamaYap(alinanSayi1:String, alinanSayi2:String) {
        if let n1 = Int(alinanSayi1), let n2 = Int(alinanSayi2) {
            sonuc.onNext("\(n1 + n2)") // Tetikleme
        }
    }
    
    func cikarmaYap(alinanSayi1:String, alinanSayi2:String) {
        if let n1 = Int(alinanSayi1), let n2 = Int(alinanSayi2) {
            sonuc.onNext("\(n1 - n2)") // Tetikleme
        }
    }
}

