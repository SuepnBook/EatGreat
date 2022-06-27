//
//  UIScrollViewExtension.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit

extension UIScrollView {
    func layoutPageViews(_ views: [UIView], withSize size: CGSize) {

        removeAllSubViews()

        let container = UIView()
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(size.height)
            make.width.equalTo(size.width * CGFloat(views.count))
        }

        for (index, view) in views.enumerated() {
            self.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.width.equalTo(size.width)
                make.top.bottom.equalToSuperview()

                if index == 0 {
                    make.leading.equalToSuperview()
                } else if index == views.count - 1 {
                    make.trailing.equalToSuperview()
                } else {
                    make.leading.equalTo(views[index - 1].snp.trailing)
                }
            }
        }
    }
}
