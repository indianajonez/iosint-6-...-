//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var mainCoordinator: CoordinatorProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootViewCoordinator = UIViewController()
        let mainCoordinator = MainCoordinator(rootViewController: rootViewCoordinator)
  //      let tabBarCoordinator = TabBarCoordinator(tabBarController: UITabBarController())
        
      window.rootViewController = mainCoordinator.start()
   //     window.rootViewController = tabBarCoordinator.start()
        window.makeKeyAndVisible()
        
        self.window = window
       self.mainCoordinator = mainCoordinator
        NetworkManager.request(for: .people(url: "4"))
        NetworkManager.request(for: .starships(url: "3"))
        
        NetworkManager.requestTaskOne { array in
            print(array)
            
        }
  //      self.mainCoordinator = tabBarCoordinator
    }
    
}
