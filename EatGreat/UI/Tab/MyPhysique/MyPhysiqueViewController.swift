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
    
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.register(cellType: MyMainPhysiqueImageTableViewCell.self)
        view.register(cellType: PhysiquePercentageTableViewCell.self)
        view.register(cellType: ExplainResultTableViewCell.self)
        view.register(cellType: InsertLinksTableViewCell.self)
        view.backgroundColor = .themeBackground1
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var tabView:TableViewTabSection = {
        let view = TableViewTabSection()
        view.delegate = self
        return view
    }()
    
    private var dataSource:[MyPhysiqueViewModel.Section] = []
    
    private lazy var viewModel:MyPhysiqueViewModel = {
        let viewModel = MyPhysiqueViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        notification()
        viewModel.setup(type: .analyze)
    }
}

//MARK: - Private Function
extension MyPhysiqueViewController {
    private func initView() {
        view.backgroundColor = .themeBackground1
        
        view.addSubview(mainPhysiqueLabel)
        
        view.addSubview(tableView)
        
        mainPhysiqueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(92)
            make.left.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainPhysiqueLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func notification() {
        Notification.observable(names: [.symptomRefresh])
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                let type:MyPhysiqueViewModel.MyPhysiqueDetailType = .analyze
                self.tabView.updateFrame(type: type)
                self.viewModel.setup(type: type)
            }.disposed(by: disposeBag)
    }
}

//MARK: - MyPhysiqueViewModelDelegate
extension MyPhysiqueViewController:MyPhysiqueViewModelDelegate {
    func reload(mainPhysique: PhysiqueType) {
        mainPhysiqueLabel.text = mainPhysique.title + "型"
    }
    
    func reload(dataSource: [MyPhysiqueViewModel.Section]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MyPhysiqueViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .mainPhysique:
            return 1
        case .detail(let type):
            switch type {
            case .analyze(let viewObjects):
                return viewObjects.count
            case .explain(let explains):
                return explains.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 32
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return tabView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section] {
        case .mainPhysique(let type):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MyMainPhysiqueImageTableViewCell.self)
            cell.updateFrame(image: type.image)
            return cell
        case .detail(let type):
            switch type {
            case .analyze(let viewObjects):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PhysiquePercentageTableViewCell.self)
                let object = viewObjects[indexPath.row]
                cell.updateFrame(object: object)
                return cell
            case .explain(let explains):
                switch explains[indexPath.row] {
                case .description(let vo):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ExplainResultTableViewCell.self)
                    cell.updateFrame(object: vo)
                    return cell
                case .insertLinks(let links):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InsertLinksTableViewCell.self)
                    cell.updateFrame(links:links)
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
}

//MARK: - MyPhysiqueTabViewDelegate
extension MyPhysiqueViewController: MyPhysiqueTabViewDelegate {
    func select(_ view: TableViewTabSection, type: MyPhysiqueViewModel.MyPhysiqueDetailType) {
        viewModel.selectViewType(type: type)
    }
}
