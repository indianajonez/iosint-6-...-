//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit

final class MainCoordinator {
    
    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    private var rootViewController: UIViewController
    
    
    // MARK: - Init
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    // MARK: - Private methods
    
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

extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        // проверка?
        // предствим, что не авторизирован
        
        let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
        self.addChildCoordinator(loginCoordinator)
        let viewController = loginCoordinator.start()
        return viewController
    }
}


