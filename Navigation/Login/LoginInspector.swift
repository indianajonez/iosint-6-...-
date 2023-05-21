//
//  LoginInspector.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.05.2023.
//

import Foundation


// 7. Создайте новую структуру LoginInspector и подпишите её на протокол LoginViewControllerDelegate; сделайте в ней реализацию метода протокола. LoginInspector должен проверять соответствие введённого логина и пароля с помощью синглтона Checker. Важный момент: чтобы делегат мог сообщить контроллеру результат проверки логина и пароля, метод протокола делегата должен содержать возвращаемое значение.

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
    
}
