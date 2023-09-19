//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 18.09.2023.
//

import UIKit
import LocalAuthentication


class LocalAuthorizationService {
    
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
}
//Создайте в этом классе метод func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void), где Bool будет служить успешной/неуспешной авторизацией.
//Внутри метода добавьте проверку возможности использования биометрии.
//Добавьте авторизацию по биометрии.
//Добавьте вызов authorizationFinished по результату проверки и авторизации.
//На экране авторизации добавьте кнопку авторизации по биометрии.
