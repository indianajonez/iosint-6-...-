//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit

final class ProfileCoordinator {
    
    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: ""),
            tag: 1
        )
        self.navigationController.tabBarItem = tabBarItem
    }
}



    // MARK: - CoordinatorProtocol

extension ProfileCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let profileViewController = ProfileViewController()
        self.navigationController.setViewControllers([profileViewController], animated: false)
        self.setupNavigationController()
        return self.navigationController
    }
}
    
