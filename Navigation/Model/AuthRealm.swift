//
//  AuthRealm.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.08.2023.
//

import Foundation
import RealmSwift

class AuthRealm: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var login: String = ""
    @Persisted var password: String = ""
    
    convenience init(login: String, password: String) {
        self.init()
        self.login = login
        self.password = password
    }
}


