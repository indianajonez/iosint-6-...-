//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import Foundation
import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]? = []
    
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func startApplication() {
        let profile = ProfileViewController(coordinator: self)
        navigationController.pushViewController(profile, animated: true)
    }
    
    func eventCheck(with type: Event) {
    }
    
    func forward(to: UIViewController) {
        // r let controller = to
        print("1,2,3")
        navigationController.pushViewController(to, animated: true)

    }
    
    func present(to: UIViewController & Coordinating) {
        navigationController.present(to, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    // r
    func pushRunLoopController() {
        let controller = RunloopViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}
    
