//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 02.06.2023.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func goToTabBarController()
}

final class LoginCoordinator {
    
    // MARK: - Public properties
    
    weak var parentCoordinator: MainCoordinatorProcotol?

    // MARK: - Private properties
    
    private var navigationController: UINavigationController
   
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
          self.navigationController = navigationController
    }
    
}



// MARK: - CoordinatorProtocol

extension LoginCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let user = User(
            login: "q",
            fullName: "Test",
            avatar: nil,
            status: "TestStatus"
        )
        let loginDelegate = Checker(user: user, password: "1")
        let loginViewController = LogInViewController(loginDelegate: loginDelegate)
        loginViewController.coordinator = self
        
        self.navigationController.setViewControllers([loginViewController], animated: false)
        return self.navigationController
    }
    
}


extension LoginCoordinator: LoginCoordinatorProtocol {
    func goToTabBarController() {
        self.parentCoordinator?.goToTabBarController()
    }
}
