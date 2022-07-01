//
//  AnswerRadioButtonGroup.swift
//  EatGreat
//
//  Created by Book on 2022/7/1.
//

import UIKit
import RxSwift

protocol AnswerRadioButtonGroupDelegate:AnyObject {
    func selectLevel(_ view:AnswerRadioButtonGroup ,level:Int)
}

class AnswerRadioButtonGroup: UIView {
    
    weak var delegate:AnswerRadioButtonGroupDelegate?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .footnote
        label.textColor = .grey2
        return label
    }()
    
    private var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private var radioButtonGroup:[RadioButton] = [RadioButton(),
                                                  RadioButton(),
                                                  RadioButton(),
                                                  RadioButton(),
                                                  RadioButton()]
    
    private var disposeBag:DisposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        reactiveX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(titleLabel)
        addSubview(stackView)
        
        for button in radioButtonGroup {
            stackView.addArrangedSubview(button)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func reactiveX(){
        for (index,button) in radioButtonGroup.enumerated() {
            button.rxControlEvent()
                .subscribe { [weak self] _ in
                    guard let self = self else { return }
                    let currentLevel = index + 1
                    self.delegate?.selectLevel(self, level: currentLevel)
                    self.selectRadioButton(button: button)
                }.disposed(by: disposeBag)
        }
    }
    
    private func selectRadioButton(button:RadioButton) {
        for button in radioButtonGroup {
            button.isSelect = false
        }
        button.isSelect = true
    }
    
    func updateFrame(level:Int?) {
        for (index,button) in radioButtonGroup.enumerated() {
            let currentLevel = index + 1
            button.isSelect = currentLevel == level
            if level == nil && button.isSelect {
                print(button.isSelect)
            }
        }
    }
}

private class RadioButton:UIButton {
    
    var isSelect:Bool = false {
        didSet {
            updateFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        layer.borderColor = UIColor.grey2.cgColor
        layer.cornerRadius = 14
        layer.borderWidth = 2
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(28)
        }
    }
    
    func updateFrame() {
        backgroundColor = isSelect ? .themePrimary : .themeBackground1
        layer.borderWidth = isSelect ? 0 : 2
    }
}
