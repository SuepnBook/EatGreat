//
//  InsertLinkCollectionViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/15.
//

import UIKit
import Kingfisher

class InsertLinkCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .themeBackground2
        return view
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.numberOfLines = 2
        label.textColor = .grey5
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        let underLine = UIView()
        underLine.backgroundColor = .grey1
        
        contentView.addSubview(imageView)
        contentView.addSubview(underLine)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }

    func updateFrame(link:InsertDomainObject.Link) {
        if let url = URL(string: link.image) {
            imageView.kf.setImage(with: url)
        }
        titleLabel.text = link.title
    }
}
