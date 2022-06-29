//
//  UIStackViewExtension.swift
//  Gozeppelin
//
//  Created by Book on 2021/7/12.
//

import UIKit

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeFully(view: view)
        }
    }

    func setBackgroundColor(color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        insertSubview(backgroundView, at: 0)

        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func addSpacingView(width: CGFloat) {
        let view = UIView()
        let spaceView = UIView()
        view.addSubview(spaceView)
        spaceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(width)
        }
        addArrangedSubview(view)
    }

    func addSpacingView(height: CGFloat) {
        let view = UIView()
        let spaceView = UIView()
        view.addSubview(spaceView)
        spaceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(height)
        }

        addArrangedSubview(view)
    }
}
