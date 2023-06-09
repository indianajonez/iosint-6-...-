//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit


enum Event {
    case buttonFeed
    case buttonLogin
    case buttonProfile
}

protocol CoordinatorProtocol { // протокол для создания координаторов
    
    var childCoordinators: [CoordinatorProtocol]? {get set}
    var navigationController: UINavigationController {get set}
    
    func startApplication()
    func eventCheck(with type: Event)
    func forward(to: UIViewController & Coordinating)
    func present(to: UIViewController & Coordinating)
    func pop()
}

protocol Coordinating { // гарантирует, что у вью контроллера будет координатор
    var coordinator: CoordinatorProtocol? {get set}
}



//final class MainCoordinator: MainCoordinatorProtocol {
//    func startApplication() -> UIViewController {
//        return FeedViewController
//    }
//}

// нужно создать фабрику






// общий паротокол для любого координатора

//protocol Coordinatable: AnyObject {
//    var childCoordinators: [Coordinatable] { get }
//    func start() -> UIViewController
//    func addChildCoordinator (_ coordinator: Coordinatable)
//}
//
//final class AppCoordinator: Coordinatable {
//    private(set) var childCoordinators: [Coordinatable] = []
//
//    private let factory: AppFactory
//
//    init(factory: AppFactory) {
//        self.factory = factory
//    }
//
//    func start() -> UIViewController { // сщздаем координаторы для всех флоу и возвращаем корневой UIViewController
//        return ...
//    }
//    func addChildCoordinator(_ coordinator: Coordinatable) {
//        guard !childCoordinators.contains(where: {$0 === coordinator}) else {
//            return
//        }
//        childCoordinators.append(coordinator)
//    }
//
//    func removeChildCoordinator(_ coordinator: Coordinatable) {
//        childCoordinators = childCoordinators.filter { $0 === coordinator}
//    }
//}


