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
        var profile = ProfileViewController()
        
        navigationController.pushViewController(profile, animated: true)
    }
    
    func eventCheck(with type: Event) {
    }
    
    
}
