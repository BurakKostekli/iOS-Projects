//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    var db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("rehber1.sqlite") // Finalde bu url ile vertabanına erişeceğiz kopyalandıktan sonra buradaki isimle bu yolda olmuş olacak zaten
        db = FMDatabase(path: veritabaniURL.path)
    }
    
     // KisiKayit
    func kaydet(kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad, kisi_tel) VALUES (?,?)", values: [kisi_ad, kisi_tel]) // kisi_ad birinci soru işaretine diğeri de ikinci soru işaretine gelmiş oluyor. Id otomatik oluşacak autoIncrement özelliği vermiştik sqlite'ta
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    // KisiDetay
    func guncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ?, kisi_tel = ? WHERE kisi_id = ?", values: [kisi_ad, kisi_tel, kisi_id])
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    // Anasayfa
    func sil(kisi_id:Int) {
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            kisileriYukle()
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func ara(aramaKelimesi:String) {
        db?.open()
        var liste = [Kisiler]()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(aramaKelimesi)%'", values: nil)
            
            while rs.next() { // Burada sırayla kişiler tablosundakileri döndürecek
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id"))!,
                                   kisi_ad: rs.string(forColumn: "kisi_ad")!,
                                   kisi_tel: rs.string(forColumn: "kisi_tel")!)
                liste.append(kisi) // Oluşan kişiyi listeye ekliyoruz
            }
            kisilerListesi.onNext(liste)
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func kisileriYukle() {
        do {
            try db?.executeUpdate("CREATE TABLE IF NOT EXISTS kisiler (kisi_id INTEGER PRIMARY KEY, kisi_ad TEXT, kisi_tel TEXT)", values: nil)
        } catch {
            print("Tablo oluşturma hatası: \(error.localizedDescription)")
        }

        
        db?.open()
        var liste = [Kisiler]()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while rs.next() { // Burada sırayla kişiler tablosundakileri döndürecek
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id"))!, 
                                   kisi_ad: rs.string(forColumn: "kisi_ad")!,
                                   kisi_tel: rs.string(forColumn: "kisi_tel")!)
                liste.append(kisi) // Oluşan kişiyi listeye ekliyoruz
            }
            kisilerListesi.onNext(liste)
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
}

