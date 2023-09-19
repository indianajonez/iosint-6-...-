//
//  FeedCoordicator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit

final class FeedCoordinator {

    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    private var navigationController: UINavigationController
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let localizedtabBarItemFeed = NSLocalizedString("tabBarItemFeed", comment: "testing")
        var tabBarItem = UITabBarItem(
            title: localizedtabBarItemFeed,
            image: UIImage(systemName: "rectangle.3.group.bubble.left"),
            tag: 0
        )
        tabBarItem.badgeColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        self.navigationController.tabBarItem = tabBarItem
    }
}



    // MARK: - CoordinatorProtocol

extension FeedCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(viewModel: viewModel)
        self.navigationController.setViewControllers([feedViewController], animated: false)
        self.setupNavigationController()
        return self.navigationController
    }
}
