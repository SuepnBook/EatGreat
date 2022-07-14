//
//  InsertLinksTableViewCell.swift
//  EatGreat
//
//  Created by Book on 2022/7/15.
//

import UIKit

class InsertLinksTableViewCell: BaseTableViewCell {
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "了解更多"
        label.font = .footnote
        label.textColor = .grey3
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.register(cellType: InsertLinkCollectionViewCell.self)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private var dataSource:[InsertDomainObject.Link] = [] {
        didSet{
            collectionView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView(){
        
        contentView.backgroundColor = .themeBackground1
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.leading.equalToSuperview().inset(25)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(180)
        }
    }
    
    func updateFrame(links:[InsertDomainObject.Link]) {
        self.dataSource = links
    }

}

extension InsertLinksTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 216, height: 180)
    }
}

extension InsertLinksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: InsertLinkCollectionViewCell.self)
        let link = dataSource[indexPath.row]
        cell.updateFrame(link: link)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let link = dataSource[indexPath.row]
        if let url = URL(string: link.url) {
            UIApplication.shared.open(url)
        }
    }
}
