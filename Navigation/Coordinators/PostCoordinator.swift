//
//  PostCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 12.08.2023.
//

import UIKit

protocol PostCoordinatorProtocol: AnyObject {
    func goToTabBarController()
}

final class PostCoordinator {
    
    // MARK: - Public properties
    
    weak var parentCoordinator: MainCoordinatorProcotol?

    // MARK: - Private properties
    
    private var navigationController: UINavigationController
   
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
          self.navigationController = navigationController
    }
    
    private func setupNavigationController() {
        let localiedTabbarItemNamePosts = NSLocalizedString("TabbarItemNamePosts", comment: "testing")
        let tabBarItem = UITabBarItem(
            title: localiedTabbarItemNamePosts,
            image: UIImage(systemName: "newspaper"),
            tag: 3
        )
        tabBarItem.badgeColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        self.navigationController.tabBarItem = tabBarItem
    }
    
}

// MARK: - CoordinatorProtocol

extension PostCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let postTableViewController = PostTableViewController()
        setupNavigationController()
        self.navigationController.setViewControllers([postTableViewController], animated: false)
        return self.navigationController
    }
    
}


extension PostCoordinator: PostCoordinatorProtocol {
    func goToTabBarController() {
        self.parentCoordinator?.goToTabBarController()
    }
}
