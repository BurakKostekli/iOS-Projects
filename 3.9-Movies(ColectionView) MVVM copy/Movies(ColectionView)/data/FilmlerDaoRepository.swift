//
//  FilmlerDaoRepository.swift
//  Movies(ColectionView)
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift
import FirebaseFirestore

class FilmlerDaoRepository {
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]())
    var collectionFilmler = Firestore.firestore().collection("Filmler") // Tabloya ulaştık
    
    func filmleriYukle() {
        
        collectionFilmler.getDocuments() { snapshot,error in // Bu sefer gerçek zamanlı bir okuma yapmıyoruz o yüzden snapshot listener kullanmadık
            var liste = [Filmler]()
            
            if let documents = snapshot?.documents { // Tablodaki tüm satırlar yani tüm belgeler
                for document in documents {
                    let data = document.data()
                    let id = document.documentID
                    let ad = data["ad"] as? String ?? ""
                    let resim = data["resim"] as? String ?? ""
                    let fiyat = data["fiyat"] as? Int ?? 0
                    
                    let film = Filmler(id: id, ad: ad, resim: resim, fiyat: fiyat)
                    liste.append(film)
                }
            }
            self.filmlerListesi.onNext(liste)
        }
    }
}


