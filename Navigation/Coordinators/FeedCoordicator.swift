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
        let feed = FeedViewController(viewModel: feedModel)
        feed.tabBarItem.title = "Feed"
        feed.tabBarItem.image = UIImage(systemName: "rectangle.3.group.bubble.left")
        feed.coordinator = self
        navigationController.pushViewController(feed, animated: true)
    }
    
    func eventCheck(with type: Event) {
        
    }
    
    func forward(to: UIViewController) {
        navigationController.pushViewController(to, animated: true)
    }
    
    func present(to: UIViewController & Coordinating) {
        navigationController.present(to, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
}
