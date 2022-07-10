//
//  PhysiquePercentageView.swift
//  EatGreat
//
//  Created by Book on 2022/7/9.
//

import UIKit

class PhysiquePercentageView: UIView {
    
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
    
    private let backgroundView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .grey1
        return view
    }()
    
    private let highlightView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .grey1
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(titleLabel)
        addSubview(percentageLabel)
        addSubview(backgroundView)
        backgroundView.addSubview(highlightView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }

    func updateFrame(type:PhysiqueType, percentage:Float) {
        titleLabel.text = type.title
        titleLabel.textColor = type.color
        let percentageTitle = Int(percentage * 100)
        percentageLabel.text = "\(percentageTitle)%"
        percentageLabel.textColor = type.color
        highlightView.backgroundColor = type.color
        
        highlightView.snp.remakeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            let multiplied = percentage * 2
            if multiplied > 0 {
                make.trailing.equalTo(backgroundView.snp.centerX).multipliedBy(multiplied)
            } else {
                make.width.equalTo(0)
            }
        }
    }
}
