//
//  ThemeButton.swift
//  Gozeppelin
//
//  Created by Book on 2021/7/10.
//

import UIKit

class ThemeButton: UIButton {
    var type: ThemeType = .enable {
        didSet {
            switch type {
            case .enable:
                self.isEnabled = true
            case .disable:
                self.isEnabled = false
            }
            updateTheme(type: type)
        }
    }

    var text: String = "" {
        didSet {
            setTitle(text, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        updateTheme(type: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        layer.cornerRadius = 8
        titleLabel?.font = .SFProDisplay700?.withSize(17)
    }

    private func updateTheme(type: ThemeType) {
        setTitleColor(type.titleColor, for: .normal)
        backgroundColor = type.backgroundColor
    }
}

extension ThemeButton {
    enum ThemeType {
        case enable
        case disable

        var titleColor: UIColor {
            switch self {
            case .enable:
                return .white
            case .disable:
                return .white
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .enable:
                return .themePrimary
            case .disable:
                return .grey2
            }
        }
    }
}
