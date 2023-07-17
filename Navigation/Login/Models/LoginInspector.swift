//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.05.2023.
//

import Foundation


// 7. Создайте новую структуру LoginInspector и подпишите её на протокол LoginViewControllerDelegate; сделайте в ней реализацию метода протокола. LoginInspector должен проверять соответствие введённого логина и пароля с помощью синглтона Checker. Важный момент: чтобы делегат мог сообщить контроллеру результат проверки логина и пароля, метод протокола делегата должен содержать возвращаемое значение.


// Вызывать методы CheckerService - как?

enum CheckError: Error {
    case notCorrectLogin
    case notCorrectPassword
    case emptyField
    case notCorrectData
    case registerError
}

struct LoginInspector: LoginViewControllerDelegate {

    
    var checkerService: CheckerServiceProtocol! // Вызывать методы CheckerService в сервисе/инспекторе LoginInspector, который закрыт протоколом LoginViewControllerDelegate и который инджектится в LoginViewController.
    
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }
    
    func check(login: String?, password: String?) throws -> Bool {
        
        guard let login = login else {
            throw CheckError.notCorrectLogin
        }
        
        guard let password = password else {
            throw CheckError.notCorrectPassword
        }
        
        checkerService.checkCredentials(email: login, pass: password) { data, error in
            guard let error = error else {
                return
            }
        }
        
        return checkerService.checkUserStartSession()
    }
    
    func register(login: String, password: String) throws -> Bool {
        checkerService.signUp(email: login, pass: password) { data, error in
//            guard error == nil else {
//                return false
//            }
        }
        return try check(login: login, password: password)
    }
}
