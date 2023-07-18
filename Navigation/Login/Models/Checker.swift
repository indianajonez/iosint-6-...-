//
//  Checker.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.05.2023.
//

enum LoginViewControllerDelegateError: Error {
    case loginIsEmpty
    case passIsEmpty
    case invalidLogin
    case invalidPass
    
    var errorDescription: String {
        switch self {
        case .loginIsEmpty:
            return "Вы не ввели логин"
        case .passIsEmpty:
            return "Вы не ввелги пароль"
        case .invalidLogin:
            return "Неправильный логин"
        case .invalidPass:
            return "Неправильный пароль"
        }
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String?, password: String?) throws -> User
    func register(login: String, password: String) throws -> User
}


final class Checker {
    
    // MARK: - Private properties
    
    private let user: User
    private let password: String
    
    
    // MARK: - Init
    
    init(user: User, password: String) {
        self.user = user
        self.password = password
    }

}



    // MARK: - LoginViewControllerDelegate

extension Checker: LoginViewControllerDelegate {

    func check(login: String?, password: String?) throws -> User {
        guard let login = login,
              !login.isEmpty
        else {
            throw LoginViewControllerDelegateError.loginIsEmpty
        }
        
        guard let password = password,
              !password.isEmpty
        else {
            throw LoginViewControllerDelegateError.passIsEmpty
        }
        
        guard login == self.user.login else {
            throw LoginViewControllerDelegateError.invalidLogin
        }
        
        guard password == self.password else {
            throw LoginViewControllerDelegateError.invalidPass
        }
        
        return self.user
    }
    
}

