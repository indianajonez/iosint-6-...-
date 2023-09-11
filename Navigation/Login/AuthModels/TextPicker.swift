//
//  TextPicker.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 15.07.2023.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func showSignupPicker(in viewController: UIViewController, completion: @escaping (String, String, String)->()) {
        let alert = UIAlertController(title: "Signup", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let text1 = alert.textFields?[0].text,
               let text2 = alert.textFields?[1].text,
               let text3 = alert.textFields?[2].text
            {
                completion(text1, text2, text3)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true)
    }
}
