//
//  MyMainPhysiqueImageTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/14.
//

import UIKit

class MyMainPhysiqueImageTableViewCell: BaseTableViewCell {
    
    private let physiqueImageView:UIImageView = {
        let view = UIImageView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView(){
        contentView.backgroundColor = .themeBackground1
        contentView.addSubview(physiqueImageView)
        
        physiqueImageView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
//            let width = UIScreen.main.bounds.width * 2 / 3
            let width = 261
            make.height.width.equalTo(width).priority(.required)
        }
    }

    func updateFrame(image:String) {
        physiqueImageView.image = UIImage(named: image)
    }
}
