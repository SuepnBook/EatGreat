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
    
    private let progressView:TestProgressView = {
        let view = TestProgressView()
        return view
    }()
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .themeBackground1
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        updateFrame()
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
    
    private func updateFrame() {
        
        let viewObject:TestProgressView.Object =
            .init(section1: .init(completionRatio: 1,
                                  isFocus: false),
                  section2: .init(completionRatio: 1,
                                  isFocus: false),
                  section3: .init(completionRatio: 1,
                                  isFocus: false),
                  section4: .init(completionRatio: 0.5,
                                  isFocus: true))
        progressView.updateFrame(viewObject: viewObject)
    }
}
