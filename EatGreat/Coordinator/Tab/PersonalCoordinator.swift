//
//  PersonalCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class PersonalCoordinator: BaseCoordinator {
    init() {
        super.init(router: .init())
        start()
    }
    
    override func start() {
        let rootVC = PersonalViewController()
        rootVC.delegate = self
        push(rootVC, animated: true)
    }
}

// MARK: - PersonalViewControllerDelegate
extension PersonalCoordinator: PersonalViewControllerDelegate {
    func goto(_ vc: PersonalViewController, type: PersonalViewModel.CellType) {
        switch type {
        case .modifyProfile:
            let vc = ProfileViewController(initType: .modify)
            vc.delegate = self
            present(viewController: vc, animated: true, completion: nil)
        case .modifyTest:
            let okAction = UIAlertAction(title: "確認", style: .default) { [weak self] _ in
                guard let self = self else { return }
                let vc = TestViewController()
                vc.delegate = self
                self.present(viewController: vc, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let alertInfo = AlertInfo(actions: [cancelAction,okAction],
                                      title: "重新進行測驗",
                                      message: "若您重新進行測驗，前次測驗結果將不予以保留，並以最新測驗結果為準。您是否確定重新進行測驗？")
            vc.alert(alertInfo: alertInfo)
        case .more:
            if let url = URL(string: "https://appshhhyqkn4694.h5.xiaoeknow.com/p/decorate/homepage") {
                UIApplication.shared.open(url)
            }
        }
    }
}

// MARK: - ProfileViewControllerDelegate
extension PersonalCoordinator: ProfileViewControllerDelegate {
    func selectNext(vc: ProfileViewController) {
        ProgressManager.showSuccessHUD(withStatus: "已儲存變更。")
        vc.dismiss(animated: true)
    }
}

// MARK: - TestViewControllerDelegate
extension PersonalCoordinator: TestViewControllerDelegate {
    func selectNext(vc: TestViewController, answer: [QuestionDomainObject.Question]) {
        ProgressManager.showSuccessHUD(withStatus: "已儲存變更，請至「我的體質」查看測驗結果。")
        vc.dismiss(animated: true)
    }
}
