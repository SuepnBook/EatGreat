//
//  TestViewController.swift
//  EatGreat
//
//  Created by Book on 2022/6/26.
//

import UIKit

protocol TestViewControllerDelegate:AnyObject {
    func selectNext(vc:TestViewController)
}

class TestViewController: BaseViewController {
    
    weak var delegate:TestViewControllerDelegate?
    
    private lazy var progressView:TestProgressView = {
        let view = TestProgressView()
        view.delegate = self
        return view
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .themeBackground1
        return tableView
    }()
    
    private lazy var viewModel:TestViewModel = {
        let viewModel = TestViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        viewModel.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private
extension TestViewController {
    private func initView() {
        view.backgroundColor = .themeBackground2
        
        view.addSubview(progressView)
        view.addSubview(tableView)
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(42)
            make.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - TestProgressViewDelegate
extension TestViewController:TestProgressViewDelegate {
    func selectSection(view: TestProgressView, category: TestProgressView.Category) {
        switch category {
        case .life:
            viewModel.selectSection(category: .life)
        case .head:
            viewModel.selectSection(category: .head)
        case .digestion:
            viewModel.selectSection(category: .digestion)
        case .trunk:
            viewModel.selectSection(category: .trunk)
        case .all:
            viewModel.selectSection(category: .all)
        }
    }
}

extension TestViewController:TestViewModelDelegate {
    func reloadTableView(testQuestions: [TestQuestion]) {
        tableView.reloadData()
    }
    
    func updateProgressView(viewObject: TestProgressView.Object) {
        progressView.updateFrame(viewObject: viewObject)
    }
}
