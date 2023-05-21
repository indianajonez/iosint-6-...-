//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 17.05.2023.
//

import Foundation

// Сделайте новую структуру MyLoginFactory, которая будет удовлетворять требованиям протокола LoginFactory и содержать генератор экземпляра LoginInspector

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
