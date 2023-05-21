//
//  Extentions.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 05.04.2023.
//

import UIKit

extension UIView {
    static var identifier: String {return String(describing: self)}
}


// MARK: - UIColor Hex-code

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}
