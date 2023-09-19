//
//  extensionUIColor.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 04.09.2023.
//

import UIKit

struct Palette {
    static let labelColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
    
    static let buttonColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
    
    static let backgroundColor: UIColor = {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return UIColor.red
            } else {
                return UIColor.green
            }
        }
    }()
}
//    struct Palette {
//        static var labelDynamicColor: UIColor = {
//            return UIColor { traitCollection in
//                if traitCollection.userInterfaceStyle == .light {
//                    return UIColor.blue
//                } else {
//                    return UIColor.green
//            }
//        }
//    }
//}

extension UIColor {
    
//    static let labelColor: UIColor = {
//        return UIColor { traitCollection in
//            if traitCollection.userInterfaceStyle == .light {
//                return UIColor.red
//            } else {
//                return UIColor.green
//            }
//        }
//    }()
//
//    static let buttonColor: UIColor = {
//        return UIColor { traitCollection in
//            if traitCollection.userInterfaceStyle == .light {
//                return UIColor(rgb: 0x4885CC)
//            } else {
//                return UIColor(rgb: 0x4005AC)
//            }
//        }
//    }()
//
//    static let backgroundColor: UIColor = {
//        return UIColor { traitCollection in
//            if traitCollection.userInterfaceStyle == .light {
//                return UIColor.red
//            } else {
//                return UIColor.green
//            }
//        }
//    }()
    
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return lightMode
            } else {
                return darkMode
            }
        }
    }
    
    static func createCGolor(lightMode: UIColor, darkMode: UIColor) -> CGColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .light {
                return lightMode
            } else {
                return darkMode
            }
        } .cgColor
    }
}
