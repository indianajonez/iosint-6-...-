//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 02.06.2023.
//

import Foundation
import UIKit

class LoginCoordinator: CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol]?
    
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
          self.navigationController = navigation
      }
    
    func startApplication() {
        let login = LogInViewController()
//        let myLoginFactory = MyLoginFactory()
        login.tabBarItem.title = "Login"
        login.tabBarItem.image = UIImage(systemName: "person.fill.viewfinder")
//        login.loginDelegate = myLoginFactory.makeLoginInspector()
        navigationController.pushViewController(login, animated: true)
    }
    
    func eventCheck(with type: Event) {
        
    }
    
    func forward(to: UIViewController & Coordinating) {
        navigationController.pushViewController(to, animated: true)
    }
    
    func present(to: UIViewController & Coordinating) {
        navigationController.present(to, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
}

// r extension LoginCoordinator: CoordinatorProtocol {
//    func start() -> UIViewController {
//        let login = LogInViewController()
//        let myLoginFactory = MyLoginFactory()
//        login.tabBarItem.title = "Login"
//        login.tabBarItem.image = UIImage(systemName: "person.fill.viewfinder")
//        login.loginDelegate = myLoginFactory.makeLoginInspector()
//        return login
//    }

    
//}
