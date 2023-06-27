//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit


final class TabBarCoordinator {
    
    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    private var tabBarController: UITabBarController
    
    
    // MARK: - Init
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    
    // MARK: - Private methods
    
    private func setupTabBarController(viewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(viewControllers, animated: false)
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
}



    // MARK: - CoordinatorProtocol

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        self.addChildCoordinator(feedCoordinator)
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        self.addChildCoordinator(profileCoordinator)
        let mediaPlayerViewCoordinator = MediaPlayerViewCoordinator(navigationController: UINavigationController())
        self.addChildCoordinator(mediaPlayerViewCoordinator)
        self.setupTabBarController(viewControllers:
        [
            feedCoordinator.start(),
            profileCoordinator.start(),
            mediaPlayerViewCoordinator.start()
        ])
        
        return self.tabBarController
    }
}
