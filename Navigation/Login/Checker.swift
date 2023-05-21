//
//  Checker.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 16.05.2023.
//

// 2. Создайте новый класс Checker и сделайте его синглтоном.
final class Checker: LoginViewControllerDelegate {
   static let shared = Checker()
    
    private init() {}
// 3. В классе Checker сделайте приватные свойства login и password, пусть они будут константами и будут иметь выбранные вами значения в заранее заданном виде.
    private let login: String = "Katay"
    private let password: String = "1234567890"
// 4. В классе Checker сделайте метод check, который будет принимать логин и пароль, введенные пользователем и возвращать true, если и логин и пароль будут совпадать и false — если нет.
    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password ? true : false
    }

}

// 5. Создайте новый протокол LoginViewControllerDelegate, для него пропишите один метод check, который будет использовать созданный выше синглтон Checker.

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
    
}

