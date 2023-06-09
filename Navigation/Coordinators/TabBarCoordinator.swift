//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import Foundation
import UIKit


final class TabBarCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol]? = []
    
    var navigationController: UINavigationController
    
    private let profile = Factory(navigationController: UINavigationController(), state: .first)
    private let feed = Factory(navigationController: UINavigationController(), state: .second)
    private let login = Factory(navigationController: UINavigationController(), state: .fourth)
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func startApplication() {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feed.navigationController, login.navigationController]
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func eventCheck(with type: Event) {
        switch type {
            
        case .buttonFeed:
            var vc: UIViewController & Coordinating = {
                let viewModel = FeedViewModel()
                let feed = FeedViewController(viewModel: viewModel)
                feed.tabBarItem.title = "Feed"
                feed.tabBarItem.image = UIImage(systemName: "rectangle.3.group.bubble.left")
                return feed
            }()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: true)
        case .buttonLogin:
            var vc: UIViewController & Coordinating = LogInViewController()
        case .buttonProfile:
            print("fdfd")
        }
    }
    
    func forward(to: UIViewController & Coordinating) {
        navigationController.pushViewController(to, animated: true)
    }
    
    func present(to: UIViewController & Coordinating) {
        navigationController.present(to, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
}


//// частный случай для координаторов с модулем
//protocol ModuleCoordinatable: Coordinatable {
////    var module: Module? { get }
////    var moduleType: Module.ModuleType { get }
//}
//
//// реализация методов добавления и удаления координаторов. Удобно для последних в иерархии.
//
//extension Coordinatable {
//    func addChildCoordinatior(_ coordinator: Coordinatable) {}
//    func removeChildCoordinator(_ coordinator: Coordinatable) {}
//}
