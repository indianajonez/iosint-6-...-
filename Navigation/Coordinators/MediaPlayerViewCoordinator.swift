//
//  MediaPlayerViewCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 23.06.2023.
//

import UIKit


final class MediaPlayerViewCoordinator {
    
    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let localizedTabBarItemMediaPlayer = NSLocalizedString("TabBarItemMediaPlayer", comment: "testing")
        let tabBarItem = UITabBarItem(
            title: localizedTabBarItemMediaPlayer,
            image: UIImage(systemName: "play.rectangle"),
            tag: 2
        )
        self.navigationController.tabBarItem = tabBarItem
    }
    
}



// MARK: - CoordinatorProtocol

extension MediaPlayerViewCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let mediaPlayerViewController = MediaPlayerViewController()
        self.navigationController.setViewControllers([mediaPlayerViewController], animated: false)
        self.setupNavigationController()
        return self.navigationController
    }
}


