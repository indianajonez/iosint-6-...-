//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.03.2023.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        self.window = window
            }

    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = .systemGray
        tabBar.viewControllers = [createFeedViewController(), createLoginViewController()]
        return tabBar
    }
// 8. Внедрите зависимость контроллера LoginViewController от LoginInspector, то есть присвойте значение свойству делегата в классе SceneDelegate или AppDelegate.
    func createLoginViewController() -> UINavigationController {
        let login = LogInViewController()
// Вынесите генерацию LoginInspector в SceneDelegate (или AppDelegate) через фабрику: теперь экземпляр делегата для LoginViewController должен создаваться через фабрику, а не напрямую.
        let myLoginFactory = MyLoginFactory()
        login.tabBarItem.title = "Login"
        login.tabBarItem.image = UIImage(systemName: "person.fill.viewfinder")
        login.loginDelegate = myLoginFactory.makeLoginInspector()
        let loginReturn = UINavigationController(rootViewController: login)
        loginReturn.navigationController?.navigationBar.isHidden = true
        
        
        return loginReturn
    }

    
    func createFeedViewController() -> UINavigationController {
        let feed = FeedViewController()
        feed.tabBarItem.title = "Feed"
        feed.tabBarItem.image = UIImage(systemName: "rectangle.3.group.bubble.left")
        return UINavigationController(rootViewController: feed)
    }
    
        func sceneDidDisconnect(_ scene: UIScene) {
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
  
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {

        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {

        }
        
    }
