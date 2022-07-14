//
//  ExplainResultTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/15.
//

import UIKit

class ExplainResultTableViewCell: BaseTableViewCell {
    
    struct Object {
        var title:String
        var subTitles:[String]
    }
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .themePrimary
        label.font = .button
        return label
    }()
    
    private let stackView:UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView(){
        
        contentView.backgroundColor = .themeBackground1
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
        }
    }
    
    private func getSubTitleLabel(text:String) -> UIView {
        let contentView = UIView()
        
        let dotLabel = UILabel()
        dotLabel.text = "・"
        dotLabel.textColor = .grey5
        dotLabel.font = .body
        
        let label = UILabel()
        label.textColor = .grey5
        label.font = .body
        label.text = text
        label.numberOfLines = 0
        
        contentView.addSubview(dotLabel)
        contentView.addSubview(label)
        
        dotLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.width.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(dotLabel.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
        }
        
        return contentView
    }
    
    func updateFrame(object:Object) {
        titleLabel.text = object.title
        
        stackView.removeFullyAllArrangedSubviews()
        
        for subTitle in object.subTitles {
            let label = getSubTitleLabel(text: subTitle)
            stackView.addArrangedSubview(label)
        }
    }
}
