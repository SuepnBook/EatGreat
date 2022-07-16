//
//  OnBoardingScrollIndexView.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit

struct OnBoardingScrollIndexObject {
    var image:String
    var title:String?
    var index:String?
}

class OnBoardingScrollIndexView: UIView {
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .themePrimary
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .headline
        return label
    }()
    
    private let indexLabel:UILabel = {
        let label = UILabel()
//        label
        label.textColor = .grey4
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .body
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(indexLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            let width = UIScreen.main.bounds.width / 3
            make.height.width.equalTo(width)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(36)
            make.height.equalTo(24)
            make.leading.trailing.equalToSuperview()
        }
        
        indexLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(36)
        }
    }
    
    func updateFrame(viewObject:OnBoardingScrollIndexObject) {
        imageView.image = UIImage(named: viewObject.image)
        titleLabel.text = viewObject.title
        indexLabel.text = viewObject.index
    }
}
