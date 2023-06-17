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

    }
    
    func startWithUser(_ user: User?) {
        let profile = ProfileViewController()
        profile.coordinator = self
        profile.currentUser = user
        navigationController.pushViewController(profile, animated: true)
    }
    
    func eventCheck(with type: Event) {
    }
    
    func forward(to: UIViewController & Coordinating) {
        self.navigationController.pushViewController(to, animated: true)
    }
    
    func present(to: UIViewController & Coordinating) {
        self.navigationController.present(to, animated: true)
    }
    
    func pop() {
        self.navigationController.popViewController(animated: true)
    }
}
    
