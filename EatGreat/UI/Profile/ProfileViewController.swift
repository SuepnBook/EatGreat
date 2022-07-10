//
//  ProfileViewController.swift
//  EatGreat
//
//  Created by Book on 2022/6/29.
//

import UIKit
import RxSwift

protocol ProfileViewControllerDelegate:AnyObject {
    func selectNext(vc:ProfileViewController)
}

class ProfileViewController: BaseViewController {
    
    enum InitType{
        case onBoarding
        case modify
    }
    
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
    
    private lazy var nickNameView:ProfileInputView = {
        let view = ProfileInputView()
        view.delegate = self
        view.titleLabel.text = "暱稱"
        view.textField.placeholder = "最多您的暱稱"
        return view
    }()
    
    private lazy var genderView:ProfileInputView = {
        let view = ProfileInputView()
        view.delegate = self
        view.titleLabel.text = "性別"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        view.pickerDataSource = viewModel.genderDataSource()
        return view
    }()
    
    private lazy var heightView:ProfileInputView = {
        let view = ProfileInputView()
        view.delegate = self
        view.titleLabel.text = "身高（公分）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        view.pickerDataSource = viewModel.heightDataSource()
        return view
    }()
    
    private lazy var weightView:ProfileInputView = {
        let view = ProfileInputView()
        view.delegate = self
        view.titleLabel.text = "體重（公斤）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        view.pickerDataSource = viewModel.weightDataSource()
        return view
    }()
    
    private lazy var bornView:ProfileInputView = {
        let view = ProfileInputView()
        view.delegate = self
        view.titleLabel.text = "出生年分（西元）"
        view.isDropDownStyle = true
        view.textField.placeholder = "請選擇"
        view.pickerDataSource = viewModel.bornDataSource()
        return view
    }()
    
    private lazy var nextButton:ThemeButton = {
        let button = ThemeButton()
        button.text = initType == .onBoarding ? "送出" : "儲存"
        button.type = .disable
        return button
    }()
    
    private let initType:InitType
    
    private let viewModel:ProfileViewModel = ProfileViewModel()
    
    init(initType:InitType) {
        self.initType = initType
        super.init()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        reactiveX()
        setupDefault()
        updateNextButtonStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar(title: nil, backgroundColor: .themeBackground2)
        setNavigationBar(isHiddenBottomLine: true)
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
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
    
    private func reactiveX() {
        nextButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.gotoNext()
            }.disposed(by: disposeBag)
    }
    
    private func setupDefault() {
        let profile = viewModel.getProfile()
        nickNameView.textField.text = profile.nickName
        genderView.textField.text = profile.gender
        if let height = profile.height{
            heightView.textField.text = String(describing: height)
        }
        if let weight = profile.weight{
            weightView.textField.text = String(describing: weight)
        }
        if let born = profile.born{
            bornView.textField.text = String(describing: born)
        }
    }
    
    private func gotoNext() {
        self.viewModel.updateProfile(nickName: nickNameView.textField.text,
                                     gender: genderView.textField.text,
                                     height: heightView.textField.text,
                                     weight: weightView.textField.text,
                                     born: bornView.textField.text)
        .observe(on: MainScheduler.instance)
        .subscribe { [weak self] _ in
            guard let self = self else { return }
            ProgressManager.showSuccessHUD(withStatus: nil)
            self.delegate?.selectNext(vc: self)
        } onFailure: { error in
            ErrorHandler.handle(error: error)
        }.disposed(by: disposeBag)
    }
    
    private func updateNextButtonStatus() {
        if nickNameView.textField.text?.isEmpty == false,
           genderView.textField.text?.isEmpty == false,
           heightView.textField.text?.isEmpty == false,
           weightView.textField.text?.isEmpty == false,
           bornView.textField.text?.isEmpty == false {
            nextButton.type = .enable
        } else {
            nextButton.type = .disable
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

// MARK: - ProfileInputViewDelegate
extension ProfileViewController:ProfileInputViewDelegate {
    func textFieldUpdate(_ view: ProfileInputView) {
        updateNextButtonStatus()
    }
}
