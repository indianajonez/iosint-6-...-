//
//  AuthRealm.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.08.2023.
//

import Foundation
import RealmSwift

class AuthRealm: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var login: String
    @Persisted var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}


