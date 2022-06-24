//
//  UIFontExtension.swift
//  Gozeppelin
//
//  Created by Book on 2021/6/24.
//

import UIKit

extension UIFont {
    enum FontName:String {
        case SFProDisplay700 = "SFProDisplay-Bold"
    }
    
    static var SFProDisplay700:UIFont? = UIFont(name: FontName.SFProDisplay700.rawValue,
                                                size: 17)
}
