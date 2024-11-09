//
//  AppDelegate.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        
        // Global navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        // Navigation Bar Rengi
        appearance.backgroundColor = UIColor(named: "BrandBlue") // Bar rengini uygulamak
        
        // Title Yazı Rengi ve Font Ayarları
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,  // Title yazı rengi
            .font: UIFont.systemFont(ofSize: 20, weight: .black)  // Title yazı fontu
        ]
        
        // Büyük Title (Large Title) Yazı Rengi ve Font Ayarları
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,  // Large title yazı rengi
            .font: UIFont.systemFont(ofSize: 20, weight: .black)  // Large title yazı fontu
        ]
        
        // Uygulamadaki tüm navigasyon barlar için bu ayarları uygula
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor.white // Geri tuşu ve diğer ikonlar
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

