//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift       // For MVVM
import FirebaseFirestore

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    var collectionKisiler = Firestore.firestore().collection("Kisiler") // Tablo kaydı oluşturduk
    
     // KisiKayit
    func kaydet(kisi_ad:String,kisi_tel:String){
        let yeniKisi:[String:Any] = ["kisi_id":"", "kisi_ad":kisi_ad, "kisi_tel":kisi_tel] // Yeni Kişi oluşturduk
        collectionKisiler.document().setData(yeniKisi)
    }
    
    // KisiDetay
    func guncelle(kisi_id:String,kisi_ad:String,kisi_tel:String){
        let guncellenenKisi:[String:Any] = ["kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        collectionKisiler.document(kisi_id).updateData(guncellenenKisi) // Artık kisi_id var kisileriYukle kısmında doldurduk onu ve burada onunla document seçtik
    }
    
    // Anasayfa
    func sil(kisi_id:String) {
        collectionKisiler.document(kisi_id).delete()
    }
    
    func ara(aramaKelimesi:String) {
        collectionKisiler.addSnapshotListener { snapshot, error in // Bu bize veri getirecek, dinleme yapacağız. Okuma yapacağız.
            var liste = [Kisiler]()
            
            if let documents = snapshot?.documents { // Var olan tüm dökümanları veriyor
                for document in documents {
                    let data = document.data() // bu sağ kısma erişmek için (Document ID dışındaki kısma)
                    let kisi_id = document.documentID // Document ID'yi kisi_id kısmına yani şu ana kadar boş beklettiğimiz kısma atıyoruz
                    let kisi_ad = data["kisi_ad"] as? String ?? ""
                    let kisi_tel = data["kisi_tel"] as? String ?? ""
                    
                    if kisi_ad.lowercased().contains(aramaKelimesi.lowercased()) {
                        let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                        liste.append(kisi)
                    }
                }
            }
            self.kisilerListesi.onNext(liste)
        }
    }
    
    func kisileriYukle() {
        
        collectionKisiler.addSnapshotListener { snapshot, error in // Bu bize veri getirecek, dinleme yapacağız. Okuma yapacağız.
            var liste = [Kisiler]()
            
            if let documents = snapshot?.documents { // Var olan tüm dökümanları veriyor
                for document in documents {
                    let data = document.data() // bu sağ kısma erişmek için (Document ID dışındaki kısma)
                    let kisi_id = document.documentID // Document ID'yi kisi_id kısmına yani şu ana kadar boş beklettiğimiz kısma atıyoruz
                    let kisi_ad = data["kisi_ad"] as? String ?? ""
                    let kisi_tel = data["kisi_tel"] as? String ?? ""
                    
                    let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                    liste.append(kisi)
                }
            }
            self.kisilerListesi.onNext(liste)
        }
    }
}


