//
//  RealmManager.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.08.2023.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func save(login: String, pass: String)
    func delete()
    func change()
}

final class RealmManager: RealmManagerProtocol {
    
    static let shared: RealmManager = RealmManager()
    
    private let realm: Realm!
    
    private init() {
        let key = Data(count: 64)
        let config = Realm.Configuration(encryptionKey: key)
        realm = try! Realm(configuration: config)
    }

    
    func save(login: String, pass: String) {
        let authData = AuthRealm(login: login, password: pass)
        do {
            try realm.write {
                realm.add(authData)
                print("SAVE TO REALM IS OOOOOK")
            }
        } catch {
            return
        }
    }
    func delete() {
        
    }
    func change() {
        
    }
    
    
}
