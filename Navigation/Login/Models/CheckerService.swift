//
//  CheckerService.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.07.2023.
//


import FirebaseAuth

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, pass: String, completion: ((AuthDataResult?, (any Error)?) -> Void)?)
    func signUp(email: String, pass: String, completion: ((AuthDataResult?, (any Error)?) -> Void)?)
    func checkUserStartSession() -> Bool
    func logout() 
}

final class CheckerService: CheckerServiceProtocol {

    func checkCredentials(email: String, pass: String, completion: ((AuthDataResult?, (any Error)?)  -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: pass, completion: completion)
    }
    
    func signUp(email: String, pass: String, completion: ((AuthDataResult?, (any Error)?)  -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: pass, completion: completion)
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    func checkUserStartSession() -> Bool {
        guard let _ = Auth.auth().currentUser else {
            return false
        }
        return true
    }
}
