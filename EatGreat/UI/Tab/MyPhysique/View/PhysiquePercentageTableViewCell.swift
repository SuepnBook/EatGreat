//
//  PhysiquePercentageTableViewCell.swift.swift
//  EatGreat
//
//  Created by Book on 2022/7/9.
//

import UIKit

class PhysiquePercentageTableViewCell: BaseTableViewCell {
    
    struct Object{
        let type:PhysiqueType
        let percentage:Float
    }
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .button
        return label
    }()
    
    private let percentageLabel:UILabel = {
        let label = UILabel()
        label.font = .mediumTitle
        return label
    }()
    
    private let backgroundLine:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .grey1
        return view
    }()
    
    private let highlightLine:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .grey1
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
        
        addSubview(titleLabel)
        addSubview(percentageLabel)
        addSubview(backgroundLine)
        backgroundLine.addSubview(highlightLine)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        backgroundLine.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }

    func updateFrame(object:Object) {
        titleLabel.text = object.type.title
        titleLabel.textColor = object.type.color
        let percentageTitle = Int(object.percentage * 100)
        percentageLabel.text = "\(percentageTitle)%"
        percentageLabel.textColor = object.type.color
        highlightLine.backgroundColor = object.type.color
        
        highlightLine.snp.remakeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            let multiplied = object.percentage * 2
            if multiplied > 0 {
                make.trailing.equalTo(backgroundLine.snp.centerX).multipliedBy(multiplied)
            } else {
                make.width.equalTo(0)
            }
        }
    }
}
