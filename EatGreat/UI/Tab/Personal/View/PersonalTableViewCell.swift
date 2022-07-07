//
//  PersonalTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class PersonalTableViewCell: BaseTableViewCell {
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .button
        label.textColor = .black
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
        
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
    }
    
    func updateFrame(title:String) {
        titleLabel.text = title
    }
}
