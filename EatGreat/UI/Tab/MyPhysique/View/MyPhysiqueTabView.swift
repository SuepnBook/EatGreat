//
//  MyPhysiqueTabView.swift
//  EatGreat
//
//  Created by Book on 2022/7/14.
//

import UIKit
import RxSwift

protocol MyPhysiqueTabViewDelegate:AnyObject {
    
}

class MyPhysiqueTabView: UIView {
    
    private let analyzeButton:TabButton = {
        let button = TabButton()
        button.titleLabel.text = "體質成分分析"
        button.updateFrame(isSelected: true)
        return button
    }()
    
    private let explainButton:TabButton = {
        let button = TabButton()
        button.titleLabel.text = "體質解說"
        button.updateFrame(isSelected: false)
        return button
    }()
    
    private let disposeBag:DisposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        reactiveX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        let underLine = UIView()
        underLine.backgroundColor = .grey1
        
        addSubview(analyzeButton)
        addSubview(explainButton)
        addSubview(underLine)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        analyzeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(0.5)
        }
        
        explainButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(analyzeButton.snp.trailing).offset(32)
        }
        
        underLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func reactiveX() {
        analyzeButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.analyzeButton.updateFrame(isSelected: true)
                self.explainButton.updateFrame(isSelected: false)
            }.disposed(by: disposeBag)
        
        explainButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.analyzeButton.updateFrame(isSelected: false)
                self.explainButton.updateFrame(isSelected: true)
            }.disposed(by: disposeBag)
    }
}

private class TabButton:UIControl {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .themePrimary
        label.font = .subTitle
        return label
    }()
    
    private lazy var focusLine:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        view.backgroundColor = .themePrimary
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(titleLabel)
        addSubview(focusLine)
        
        self.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        focusLine.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.width.equalTo(32)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func updateFrame(isSelected:Bool) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            self.titleLabel.textColor = isSelected ? .themePrimary : .grey1
            self.focusLine.isHidden = !isSelected
        }
    }
}
