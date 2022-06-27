//
//  UIViewExtension.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit

extension UIView {
    func removeAllSubViews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

