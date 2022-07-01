//
//  BaseTableViewCell.swift
//  Gozeppelin
//
//  Created by Book on 2020/4/9.
//  Copyright © 2020 Gozeppelin. All rights reserved.
//

import Reusable
import UIKit

class BaseTableViewCell: UITableViewCell, Reusable {
    private let bottomLine = UIView()

    var baseIndexPath: IndexPath? {
        let tableView = superview as? UITableView
        return tableView?.indexPath(for: self)
    }

    var isEnableBottomLine: Bool = false {
        didSet {
            updateFrame()
        }
    }

    var isFullLeftBottomLine: Bool = false {
        didSet {
            updateFrame()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initView()
        updateFrame()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        bottomLine.backgroundColor = UIColor.separator
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(15)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

    private func updateFrame() {
        bottomLine.isHidden = !isEnableBottomLine

        let leftOffset = isFullLeftBottomLine ? 0 : 15
        bottomLine.snp.updateConstraints { make in
            make.left.equalTo(snp.left).offset(leftOffset)
        }
    }
}
