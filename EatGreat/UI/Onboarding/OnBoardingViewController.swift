//
//  OnBoardingViewController.swift
//  EatGreat
//
//  Created by Book on 2022/6/24.
//

import UIKit
import SnapKit

protocol OnBoardingViewControllerDelegate: AnyObject {
    func selectStart(vc:OnBoardingViewController)
}

class OnBoardingViewController: BaseViewController {
    
    weak var delegate:OnBoardingViewControllerDelegate?
    
    private var startButton:ThemeButton = {
        let button = ThemeButton()
        button.text = "開始測驗"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        reactiveX()
    }
}

extension OnBoardingViewController {
    private func initView() {
        view.backgroundColor = .themeBackground1
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func reactiveX() {
        startButton
            .rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectStart(vc: self)
            }.disposed(by: disposeBag)
    }
}
