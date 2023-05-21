//
//  LoginFactory.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 17.05.2023.
//

import Foundation

// Создайте новый протокол LoginFactory с одним методом без параметров makeLoginInspector, который будет возвращать LoginInspector.

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
