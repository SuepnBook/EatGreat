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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: TestQuestionTableViewCell.self)
        tableView.backgroundColor = .themeBackground1
        return tableView
    }()
    
    private lazy var nextButton:ThemeButton = {
        let button = ThemeButton()
        button.text = "下一步"
        button.type = .disable
        return button
    }()
    
    private lazy var viewModel:TestViewModel = {
        let viewModel = TestViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private var testQuestions: [TestQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        reactiveX()
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
        view.backgroundColor = .themeBackground1
        
        let progressBackground = UIView()
        progressBackground.backgroundColor = .themeBackground2
        
        view.addSubview(progressBackground)
        progressBackground.addSubview(progressView)
        view.addSubview(tableView)
        view.addSubview(nextButton)
        
        progressBackground.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.left.bottom.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func reactiveX() {
        nextButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.selectNextButton()
            }.disposed(by: disposeBag)
    }
}

// MARK: - TestViewModelDelegate
extension TestViewController:TestViewModelDelegate {
    
    func updateDataSource(testQuestions:[TestQuestion]) {
        self.testQuestions = testQuestions
    }
    func reloadTableView(testQuestions: [TestQuestion]) {
        self.testQuestions = testQuestions
        tableView.reloadSections(.init(integer: 0), with: .automatic)
    }
    
    func updateProgressView(viewObject: TestProgressView.Object) {
        progressView.updateFrame(viewObject: viewObject)
    }
    
    func scrollToIndexPath(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func updateNextButton(title: String, isEnable: Bool) {
        nextButton.text = title
        if isEnable {
            nextButton.type = .enable
        } else {
            nextButton.type = .disable
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

// MARK: - UITableViewDelegate
extension TestViewController:UITableViewDelegate{
    
}

// MARK: - UITableViewDataSource
extension TestViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TestQuestionTableViewCell.self)
        let question = testQuestions[indexPath.row]
        cell.updateFrame(question: question, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - TestQuestionTableViewCellDelegate
extension TestViewController:TestQuestionTableViewCellDelegate {
    func selectFrequency(_ view: TestQuestionTableViewCell, level: Int) {
        guard let index = view.indexPath?.row else {
            return
        }
        viewModel.selectFrequency(index: index, level: level)
    }
    
    func selectSerious(_ view: TestQuestionTableViewCell, level: Int) {
        guard let index = view.indexPath?.row else {
            return
        }
        viewModel.selectSerious(index: index, level: level)
    }
}


