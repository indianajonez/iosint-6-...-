//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 01.06.2023.
//

import UIKit

protocol MainCoordinatorProcotol: AnyObject {
    func goToTabBarController()
}

final class MainCoordinator {
    
    // MARK: - Private properties
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    private var rootViewController: UIViewController
    
    
    // MARK: - Init
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    
    // MARK: - Private methods
    
    private func setFlow(to newViewController: UIViewController) {
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        self.rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self.rootViewController)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        self.rootViewController.children[0].willMove(toParent: nil)
        self.rootViewController.children[0].navigationController?.navigationBar.isHidden = true
        self.rootViewController.addChild(newViewController)
        newViewController.view.frame = self.rootViewController.view.bounds
        
        self.rootViewController.transition(
            from: self.rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {}
        ) { _ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
            }
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

extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        // проверка?
        // предствим, что не авторизирован
        
        let loginCoordinator = LoginCoordinator(navigationController: UINavigationController())
        loginCoordinator.parentCoordinator = self
        self.addChildCoordinator(loginCoordinator)
        let loginViewController = loginCoordinator.start()
        
        self.setFlow(to: loginViewController)
        
        return self.rootViewController
    }
}


extension MainCoordinator: MainCoordinatorProcotol {
    func goToTabBarController() {
        // УРА!!!!
        print("EHF!")
        
        let tabBarCoordinator = TabBarCoordinator(tabBarController: UITabBarController())
        self.addChildCoordinator(tabBarCoordinator)
        let tabBarController = tabBarCoordinator.start()
        
        self.switchFlow(to: tabBarController)
        self.removeChildCoordinator(self.childCoordinators[0])
    }
}
