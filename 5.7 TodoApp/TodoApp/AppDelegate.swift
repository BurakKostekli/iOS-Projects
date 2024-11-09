//
//  AppDelegate.swift
//  TodoApp
//
//  Created by Burak Köstekli on 15.10.2024.
//

import UIKit
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Realm migration
        
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 4 {
                    // migration space if needed
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
        
        
        do {
            _ = try Realm()
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
        
        
        // NAVIGATION BAR DESIGN
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemBlue
        
        let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        
        navBarAppearance.titleTextAttributes = titleAttributes
        navBarAppearance.largeTitleTextAttributes = titleAttributes
        navBarAppearance.backButtonAppearance.normal.titleTextAttributes = titleAttributes
        
        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
        navBar.compactAppearance = navBarAppearance
        navBar.tintColor = .white
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
}



// Loaction of Realm File : /Users/mymac/Library/Developer/CoreSimulator/Devices/1E875494-9F54-4615-AFD7-E59BADA6D3BF/data/Containers/Data/Application/3A1C348B-C655-4C4C-89A1-C74C878A8399/Documents/default.realm
