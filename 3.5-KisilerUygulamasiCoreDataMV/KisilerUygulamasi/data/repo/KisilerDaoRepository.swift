//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift
import CoreData

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[KisilerModel]>(value: [KisilerModel]())
    
    let context = appDelegate.persistentContainer.viewContext // veritabanına erişme yetkisi gibi bir şey
    
     // KisiKayit
    func kaydet(kisi_ad:String,kisi_tel:String){
        let kisi = KisilerModel(context: context) // Entity'deki nesneye kaydedilmesi istenen veriler ile bir nesne oluşturmuş oluyoruz aşağıdaki kodlarla beraber
        kisi.kisi_ad = kisi_ad
        kisi.kisi_tel = kisi_tel
        
        appDelegate.saveContext() // oluşturduğum nesneyi kaydet
    }
    
    // KisiDetay
    func guncelle(kisi:KisilerModel,kisi_ad:String,kisi_tel:String){
        kisi.kisi_ad = kisi_ad
        kisi.kisi_tel = kisi_tel
        
        appDelegate.saveContext()
    }
    
    // Anasayfa
    func sil(kisi:KisilerModel) {
        context.delete(kisi)
        appDelegate.saveContext()
        kisileriYukle()
    }
    
    func ara(aramaKelimesi:String) {
        do {
            let fr = KisilerModel.fetchRequest()
            fr.predicate = NSPredicate(format: "kisi_ad CONTAINS[c] %@", aramaKelimesi) // [c] yazmazsak büyük küçük harf uyumu isteyecektir. aramaKelimesi %@ kısmına yerleşiyor
            let liste = try context.fetch(fr)
            kisilerListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func kisileriYukle() {
        do {
            let liste = try context.fetch(KisilerModel.fetchRequest()) // Yukarıda girdiğimiz context'i kullandık. fetch olarak hangi Entity'deki kisileri istiyorsak onun Requesti
            kisilerListesi.onNext(liste)                               // listeye gelen tüm kisilerModel nesnelerini arayüze gönderiyoruz
        } catch {
            print(error.localizedDescription)
        }
    }
}
