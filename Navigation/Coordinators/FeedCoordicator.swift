//
//  FeedCoordicator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import Foundation
import UIKit


// частный случай для координаторов с модулем

final class FeedCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]? = []
    
    var navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func startApplication() {
        let feedModel = FeedViewModel()
        var feed = FeedViewController(viewModel: feedModel)
        feed.tabBarItem.title = "Feed"
        feed.tabBarItem.image = UIImage(systemName: "rectangle.3.group.bubble.left")
        navigationController.pushViewController(feed, animated: true)
    }
    
    func eventCheck(with type: Event) {
    }
    
    
}
