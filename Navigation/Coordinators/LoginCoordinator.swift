//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 02.06.2023.
//

import UIKit

final class LoginCoordinator {

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
        
        self.navigationController.setViewControllers([loginViewController], animated: false)
        return self.navigationController
    }
    
}
