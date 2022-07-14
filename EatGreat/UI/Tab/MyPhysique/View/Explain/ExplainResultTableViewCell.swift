//
//  ExplainResultTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/15.
//

import UIKit

class ExplainResultTableViewCell: BaseTableViewCell {
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .themePrimary
        label.font = .button
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView(){
        
    }
    
    func updateFrame(title:String?) {
        titleLabel.text = title
    }
}
