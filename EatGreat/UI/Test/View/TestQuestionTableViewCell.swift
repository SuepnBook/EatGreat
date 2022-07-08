//
//  TestQuestionTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/1.
//

import UIKit

protocol TestQuestionTableViewCellDelegate:AnyObject {
    func selectFrequency(_ view:TestQuestionTableViewCell , level:Int)
    func selectSerious(_ view:TestQuestionTableViewCell , level:Int)
}

class TestQuestionTableViewCell: BaseTableViewCell {
    
    weak var delegate:TestQuestionTableViewCellDelegate?
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .button
        label.textColor = .grey5
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var frequencyButtonGroup:AnswerRadioButtonGroup = {
        let view = AnswerRadioButtonGroup()
        view.delegate = self
        view.titleLabel.text = "發生頻率"
        return view
    }()
    
    private lazy var seriousButtonGroup:AnswerRadioButtonGroup = {
        let view = AnswerRadioButtonGroup()
        view.delegate = self
        view.titleLabel.text = "嚴重程度"
        return view
    }()
    
    var indexPath: IndexPath?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView(){
        contentView.backgroundColor = .themeBackground1
        
        let underLine = UIView()
        underLine.backgroundColor = .grey2
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(frequencyButtonGroup)
        contentView.addSubview(seriousButtonGroup)
        contentView.addSubview(underLine)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        frequencyButtonGroup.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        seriousButtonGroup.snp.makeConstraints { make in
            make.top.equalTo(frequencyButtonGroup.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(seriousButtonGroup.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateFrame(question:QuestionDomainObject.Question, indexPath:IndexPath) {
        self.indexPath = indexPath
        titleLabel.text = question.title
        frequencyButtonGroup.updateFrame(level: question.frequency)
        seriousButtonGroup.updateFrame(level: question.serious)
    }
}

extension TestQuestionTableViewCell:AnswerRadioButtonGroupDelegate {
    func selectLevel(_ view: AnswerRadioButtonGroup, level: Int) {
        if view == frequencyButtonGroup {
            delegate?.selectFrequency(self, level: level)
        }
        if view == seriousButtonGroup {
            delegate?.selectSerious(self, level: level)
        }
    }
}
