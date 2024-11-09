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
        filmlerListesi = frepo.filmlerListesi
        filmleriYukle()
    }
    
    func filmleriYukle() {
        frepo.filmleriYukle()
    }
}

