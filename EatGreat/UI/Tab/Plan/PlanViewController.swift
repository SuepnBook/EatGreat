//
//  PlanViewController.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit
import RxCocoa
import RxSwift

class PlanViewController: BaseViewController {
    
    private let planLabel:UILabel = {
        let label = UILabel()
        label.font = .mediumTitle
        label.textColor = .themePrimary
        label.text = "專屬計畫"
        return label
    }()
    
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.register(cellType: SuggestTableViewCell.self)
        view.register(cellType: InsertLinksTableViewCell.self)
        view.tableFooterView = UIView(frame: .init(origin: .zero,
                                                   size: .init(width: 1, height: 80)))
        view.backgroundColor = .themeBackground1
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private var dataSource: [PlanViewModel.CellType] = []

    private lazy var viewModel:PlanViewModel = {
        let viewModel = PlanViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        notification()
        viewModel.setup()
    }
}

//MARK: - Private Function
extension PlanViewController {
    private func initView() {
        view.backgroundColor = .themeBackground1
        
        view.addSubview(planLabel)
        
        view.addSubview(tableView)
        
        planLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(92)
            make.left.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(planLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func notification() {
        Notification.observable(names: [.symptomRefresh])
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.setup()
            }.disposed(by: disposeBag)
    }
}

//MARK: - PlanViewModelDelegate
extension PlanViewController: PlanViewModelDelegate {
    func reload(dataSource: [PlanViewModel.CellType]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .description(let vo):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SuggestTableViewCell.self)
            cell.updateFrame(object: vo)
            return cell
        case .insertLinks(let links):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InsertLinksTableViewCell.self)
            cell.updateFrame(links:links)
            return cell
        }
    }
}
