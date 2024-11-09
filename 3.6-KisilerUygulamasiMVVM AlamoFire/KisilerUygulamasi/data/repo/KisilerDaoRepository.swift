//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Burak Köstekli on 28.11.2023.
//

import Foundation
import RxSwift
import Alamofire

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
     // KisiKayit
    func kaydet(kisi_ad:String,kisi_tel:String){
        let params:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel] // post yöntemi yani bizden veri istiyor biz de bu şekilde aldık aşağıda kullandık
        
        AF.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("\(cevap.message!)") // Bu kısımda verilere bu şekilde ulaşabiliyoruz. Yukarıda kaydetme işlemini post metoduyla zaten göndererek yaptık.
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // KisiDetay
    func guncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        let params:Parameters = ["kisi_id":kisi_id,"kisi_ad":kisi_ad,"kisi_tel":kisi_tel] // API'den baktık bu sefer 3 veri istiyor
        
        AF.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("\(cevap.message!)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Anasayfa
    func sil(kisi_id:Int) {
        let params:Parameters = ["kisi_id":kisi_id]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("\(cevap.message!)")
                    self.kisileriYukle()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func ara(aramaKelimesi:String) {
        let params:Parameters = ["kisi_ad":aramaKelimesi]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php", method: .post,parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                    
                    if let liste = cevap.kisiler {
                        self.kisilerListesi.onNext(liste)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func kisileriYukle() {
                                                                                                            // Metod olarak bizden bir veri veya bilgi istemediği için .get
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php", method: .get).response { response in // bu soldaki response'un kendisi, yani farklı şekilde yazarakta kullanlr
            if let data = response.data { // Bu data o alacağımız tüm json kodlarının kendisi
                do {
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data) // Dönüştürmek istediğimiz class'ı ve datanın kendisini yazıp dönüştürdük
                    
                    if let liste = cevap.kisiler { // Tüm listeye erişmek için (JSON Formatına bakarak anlıyoruz)
                        self.kisilerListesi.onNext(liste)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}

