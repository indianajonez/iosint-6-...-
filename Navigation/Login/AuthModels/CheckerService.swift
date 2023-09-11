//
//  CheckerService.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.07.2023.
//


import FirebaseAuth

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, pass: String, completion: @escaping (User?, _ errorString: String?) -> Void )
    func signUp(email: String, pass: String, completion: @escaping (Bool, _ errorString: String?) -> Void )
    func checkUserStartSession() -> Bool
    func logout() 
}

final class CheckerService: CheckerServiceProtocol {

    func checkCredentials(email: String, pass: String, completion: @escaping (User?, _ errorString: String?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            if let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                }
            }
            guard let user = authResult?.user else {
                DispatchQueue.main.async {
                    completion(nil, error?.localizedDescription)
                }
                return
            }
            let newUser = User(login: user.email!, fullName: user.email!, status: "khrfeih")
        completion(newUser, nil)
        }
    }
    
    func signUp(email: String, pass: String, completion: @escaping (Bool, _ errorString: String?) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(false, "Такой email уже зарегистрирован")
                case AuthErrorCode.weakPassword.rawValue:
                    completion(false, "Необходимо ввести пароль длиннее")
                default:
                    completion(false, "Что-то пошло не так, попробуйте еще раз")
                }
            } else {
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            }
        }
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
