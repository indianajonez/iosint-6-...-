//
//  CustomAlert.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 12.06.2023.
//
import UIKit
import Foundation

class CustomAlert: UIAlertController {
    let titleAlert: String
    let messageAlert: String
    let okTitle: String
    var completionOk: ()->()
    var alert: UIAlertController?
    
    init(titleAlert: String, messageAlert: String, okTitle: String, completionOk: @escaping ()->()) {
        self.titleAlert = titleAlert
        self.messageAlert = messageAlert
        self.okTitle = okTitle
        self.completionOk = completionOk
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            self.completionOk()
        }
        alert.addAction(okAction)
        self.alert = alert
    }
}


