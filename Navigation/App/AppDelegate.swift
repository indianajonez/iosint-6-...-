//
//  AppDelegate.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 14.03.2023.
//

import UIKit
import FirebaseCore
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PostStorage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.playback, mode: .moviePlayback)
//        } catch {
//            print(error.localizedDescription)
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
     
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //Auth.auth().logOut()
        CheckerService().logout()
        print("LOG OUT")
    }
}

