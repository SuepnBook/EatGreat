//
//  ProfileViewController.swift
//  EatGreat
//
//  Created by Book on 2022/6/29.
//

import UIKit

protocol ProfileViewControllerDelegate:AnyObject {
    func selectNext(vc:ProfileViewController)
}

class ProfileViewController: BaseViewController {
    
    weak var delegate:ProfileViewControllerDelegate?
    
    private let topView:UIView = {
        let view = UIView()
        view.backgroundColor = .themeBackground2
        return view
    }()
    
    private let largeTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "我的資料"
        label.font = .mediumTitle
        label.textColor = .themePrimary
        return label
    }()
    
    private let subTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "「擇食」將配合您的測驗結果和個人生理狀態，制定出專屬於您的擇食建議和改善計劃。"
        label.numberOfLines = 0
        label.font = .subHead
        label.textColor = .grey4
        return label
    }()
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let nickNameView:ProfileInputView = {
        let view = ProfileInputView()
        view.titleLabel.text = "暱稱"
        view.textField.placeholder = "最多輸入 8 字元"
        return view
    }()
    
    private let genderView:ProfileInputView = {
        let view = ProfileInputView()
        view.titleLabel.text = "性別"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        return view
    }()
    
    private let heightView:ProfileInputView = {
        let view = ProfileInputView()
        view.titleLabel.text = "身高（公分）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        return view
    }()
    
    private let weightView:ProfileInputView = {
        let view = ProfileInputView()
        view.titleLabel.text = "體重（公斤）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        return view
    }()
    
    private let bornView:ProfileInputView = {
        let view = ProfileInputView()
        view.titleLabel.text = "出生年分（西元）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        return view
    }()
    
    private lazy var nextButton:ThemeButton = {
        let button = ThemeButton()
        button.text = "送出"
        button.type = .disable
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(title: nil, backgroundColor: .themeBackground2)
        setNavigationBar(isHiddenBottomLine: true)
    }
}

//MARK: - Private Function
extension ProfileViewController {
    private func initView() {
        
        view.backgroundColor = .themeBackground1
        
        view.addSubview(scrollView)
        view.addSubview(nextButton)
        
        scrollView.addSubview(stackView)
        
        topView.addSubview(largeTitleLabel)
        topView.addSubview(subTitleLabel)
        
        stackView.addArrangedSubview(topView)
        stackView.addSpacingView(height: 32)
        stackView.addArrangedSubview(nickNameView)
        stackView.addArrangedSubview(genderView)
        stackView.addArrangedSubview(heightView)
        stackView.addArrangedSubview(weightView)
        stackView.addArrangedSubview(bornView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
        largeTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(largeTitleLabel.snp.bottom).offset(31)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

// MARK: - ScrollViewDelegate
extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        } else if scrollView.contentOffset.y >= 58 {
            setNavigationBar(title: "我的資料", backgroundColor: .themeBackground2,titleColor: .themePrimary)
        } else {
            setNavigationBar(title: nil, backgroundColor: .themeBackground2)
        }
    }
}
