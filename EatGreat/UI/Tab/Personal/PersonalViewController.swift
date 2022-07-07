//
//  PersonalViewController.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

protocol PersonalViewControllerDelegate:AnyObject {
    func goto(_ vc:PersonalViewController , type:PersonalViewModel.CellType)
}

class PersonalViewController: BaseViewController {
    
    weak var delegate:PersonalViewControllerDelegate?
    
    private let largeTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "個人設定"
        label.font = .mediumTitle
        label.textColor = .themePrimary
        return label
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .themeBackground1
        tableView.register(cellType: PersonalTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var dataSource:[PersonalViewModel.CellType] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let viewModel:PersonalViewModel = PersonalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupData()
    }
}

// MARK: - Private Function
extension PersonalViewController {
    private func initView() {
        view.backgroundColor = .themeBackground1
        
        view.addSubview(largeTitleLabel)
        view.addSubview(tableView)
        
        largeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(95)
            make.leading.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(largeTitleLabel.snp.bottom).offset(18)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupData() {
        self.dataSource = viewModel.getDataSource()
    }
}

// MARK:  - UITableViewDelegate,UITableViewDataSource
extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PersonalTableViewCell.self)
        let type = dataSource[indexPath.row]
        cell.updateFrame(title: type.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = dataSource[indexPath.row]
        delegate?.goto(self, type: type)
    }
}

