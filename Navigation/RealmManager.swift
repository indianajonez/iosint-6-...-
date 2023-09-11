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
        let privateKey: [UInt8] = [115, 117, 112, 101, 114, 95, 115, 101, 99, 114, 116, 95, 107, 101, 121]
        
        var key = Data(count: 64)
//        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
//            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
//        }
        let config = Realm.Configuration(encryptionKey: key)
        realm = try? Realm(configuration: config)
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
