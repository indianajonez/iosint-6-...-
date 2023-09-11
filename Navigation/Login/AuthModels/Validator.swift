//
//  Validator.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 14.07.2023.
//

import Foundation

final class Validator {
    static let shared = Validator()
    
    private init(){}
    
    func checkMail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result

    }
    
    func checkPassword(_ pass: String) -> Bool {
        pass.count >= 6
    }
}
