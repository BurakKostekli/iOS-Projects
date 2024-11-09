//
//  ViewController.swift
//  Notification
//
//  Created by Burak Köstekli on 7.12.2023.
//

import UIKit
import UserNotifications // Ekledik

class ViewController: UIViewController {
    
    var izinKontrol = false //Daha önce izin verildi mi?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in // granted bize bildirim izni onaylandı mı
            self.izinKontrol = granted
            
            if granted {
                print("İzin alma başarılı")
            } else {
                print("İzin alma başarısız")
            }
        })
    }

    @IBAction func buttonBildirim(_ sender: Any) {
        if izinKontrol { // true ise çalıştır
            let icerik = UNMutableNotificationContent()
            
            icerik.title = "Başlık"
            icerik.subtitle = "Alt Başlık"
            icerik.body = "Mesaj"
            icerik.badge = 1
            icerik.sound = UNNotificationSound.default // Telefonun bildirim sesi
            
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // Süre aralığımız (10 saniye sonra), ve tekrar tekrar gösterme dedim
            
            let bildirimIstek = UNNotificationRequest(identifier: "id", content: icerik, trigger: tetikleme) // id önemlidir, aynı id'li bildirimler gruplanacaktır (beğeniler için, yorumlar için)
            UNUserNotificationCenter.current().add(bildirimIstek) // Ekliyoruz
        }
    }
    
}


extension ViewController : UNUserNotificationCenterDelegate {
    
    // willPresent (CompletionHandler'le olanı)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // didReceive (withCompletionHandler'lı olanı) Bildirime tıklanılınca çalışıyor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setBadgeCount(0, withCompletionHandler: nil) // Bu şekilde badge count sıfırlandı
        
        let app = UIApplication.shared
        
        if app.applicationState == .active { // Bildirim önplandayken mi seçildi arkaplandayken mi anlayabiliriz :
            print("Önplan: Bildirim Seçildi")
        }
        if app.applicationState == .inactive {
            print("Arkaplan: Bildirim Seçildi")
        }
        
        completionHandler()
    }
}

