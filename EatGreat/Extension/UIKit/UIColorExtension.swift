//
//  UIColorExtension.swift
//  Gozeppelin
//
//  Created by Book on 2021/6/25.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, gre: CGFloat, blu: CGFloat, alp: CGFloat = 1) {
        self.init(red: red / 255, green: gre / 255, blue: blu / 255, alpha: alp)
    }

    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255,
                  blue: CGFloat(b) / 255,
                  alpha: CGFloat(a) / 255)
    }
}

//MARK: - Theme
extension UIColor {
    class var themePrimary: UIColor {
        UIColor(red: 175, gre: 104, blu: 80)
    }

    class var themeBackground1: UIColor {
        UIColor(red: 253, gre: 249, blu: 243)
    }
    
    class var themeBackground2: UIColor {
        UIColor(red: 229, gre: 208, blu: 176)
    }

    class var error: UIColor {
        UIColor(red: 234, gre: 66, blu: 66)
    }
}

//MARK: - Grey
extension UIColor {
    class var grey1: UIColor {
        UIColor(red: 216, gre: 216, blu: 216)
    }
    class var grey2: UIColor {
        UIColor(red: 187, gre: 187, blu: 187)
    }

    class var grey3: UIColor {
        UIColor(red: 146, gre: 146, blu: 146)
    }

    class var grey4: UIColor {
        UIColor(red: 82, gre: 82, blu: 82)
    }

    class var grey5: UIColor {
        UIColor(red: 48, gre: 48, blu: 48)
    }
}
