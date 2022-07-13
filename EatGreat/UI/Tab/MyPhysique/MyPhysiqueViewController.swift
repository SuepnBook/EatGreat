//
//  MyPhysiqueViewController.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit
import RxCocoa
import RxSwift

class MyPhysiqueViewController: BaseViewController {
    
    private let mainPhysiqueLabel:UILabel = {
        let label = UILabel()
        label.font = .mediumTitle
        label.textColor = .themePrimary
        return label
    }()
    
    private let physiqueImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let tabView:MyPhysiqueTabView = {
        let view = MyPhysiqueTabView()
        return view
    }()
    
    private lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let stackView:UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let viewModel:MyPhysiqueViewModel = MyPhysiqueViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        updateFrame()
        notification()
    }
}

//MARK: - Private Function
extension MyPhysiqueViewController {
    private func initView() {
        view.backgroundColor = .themeBackground1
        
        view.addSubview(mainPhysiqueLabel)
        view.addSubview(physiqueImageView)
        
        view.addSubview(tabView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        mainPhysiqueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(92)
            make.left.equalToSuperview().inset(24)
        }
        
        physiqueImageView.snp.makeConstraints { make in
            make.top.equalTo(mainPhysiqueLabel.snp.bottom)
            let width = UIScreen.main.bounds.width * 2 / 3
            make.height.width.equalTo(width)
            make.centerX.equalToSuperview()
        }
        
        tabView.snp.makeConstraints { make in
            make.top.equalTo(physiqueImageView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func updateFrame() {
            let mainPhysique = viewModel.getMainPhysique()
            mainPhysiqueLabel.text = mainPhysique.title + "型"
            physiqueImageView.image = UIImage(named: mainPhysique.image)
            
            let physiques = viewModel.getAllPhysiquePercentage()
            
            stackView.removeFullyAllArrangedSubviews()
            
            for physique in physiques {
                let view = PhysiquePercentageView()
                view.updateFrame(type: physique.0, percentage: physique.1)
                stackView.addArrangedSubview(view)
            }
            
            stackView.addSpacingView(height: 80)
        }
    
    private func notification() {
        Notification.observable(names: [.symptomRefresh])
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.updateFrame()
            }.disposed(by: disposeBag)
    }
}

