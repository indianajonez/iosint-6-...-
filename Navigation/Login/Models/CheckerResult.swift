//
//  CheckerResult.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 23.06.2023.
//

import Foundation

class ResultTest {
    var loginViewControllerDelegate1: LoginViewControllerDelegateForResult?
    
    func test() {
        let result = self.loginViewControllerDelegate1?.check(login: "", password: "")
        switch result {
        case .success(let currentUser): break
        case .failure(let error): break
        case .none:
            print("Ошибка не найдена")
        }
    }
}

enum LoginViewControllerDelegateError1: Error {
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

protocol LoginViewControllerDelegateForResult {
    func check(login: String?, password: String?) -> Result<User, LoginViewControllerDelegateError1>
}


final class CheckerForResult {
    
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

extension CheckerForResult: LoginViewControllerDelegateForResult {

    func check(login: String?, password: String?) -> Result<User, LoginViewControllerDelegateError1> {
        guard let login = login,
              !login.isEmpty
        else {
            return .failure(.loginIsEmpty)
        }
        
        guard let password = password,
              !password.isEmpty
        else {
            return .failure(.passIsEmpty)
        }
        
        guard login == self.user.login else {
            return .failure(.invalidLogin)
        }
        
        guard password == self.password else {
            return .failure(.invalidPass)
        }
        
        return .success(self.user)
    }
    
}

