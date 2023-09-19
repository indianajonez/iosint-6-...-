//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 18.09.2023.
//

import UIKit
import LocalAuthentication


class LocalAuthorizationService {
        
        func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
            let context = LAContext()
            var error: NSError?
            
            // Проверка, если face ID доступно
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Авторизуйтесь, используя Face ID"
                
                // Выполнить ауткнтификацию по Face ID
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    DispatchQueue.main.async {
                        if success {
                            // Face ID authentication succeeded
                            authorizationFinished(true)
                        } else {
                            // Face ID authentication failed
                            authorizationFinished(false)
                        }
                    }
                }
            } else {
                // Face ID is not available on the device
                authorizationFinished(false)
            }
        }
    }
    
//    func authorizeIfPossible() {
//        let context = LAContext()
//        var error: NSError? = nil
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
//                                     error: &error) {
//            let reason = "Please authorize with touch id!"
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
//                                   localizedReason: reason) { [weak self] success, error in
//                DispatchQueue.main.async {
//                    guard success, error == nil else {
//                        // falied
//
//                        let alert = UIAlertController(title: "Failed to Authenticate",
//                                                      message: "Please try again.",
//                                                      preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "Dismiss",
//                                                      style: .cancel,
//                                                      handler: nil))
//                        self?.present(alert, animated: true)
//                        return
//                    }
//
//
//                    // show other screen
//                    // success
//                    let vc = UIViewController()
//                    vc.title = "Welcome"
//                    vc.view.backgroundColor = .systemBlue
//                    self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
//                }
//            }
//        }
//        else {
//            // can not use
//            let alert = UIAlertController(title: "Unavailable",
//                                          message: "You cant use this featire",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Dismiss",
//                                          style: .cancel,
//                                          handler: nil))
//            present(alert, animated: true)
//        }
//    }

