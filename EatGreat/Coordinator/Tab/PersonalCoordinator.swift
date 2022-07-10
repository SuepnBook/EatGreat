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
            let vc = TestViewController()
            vc.delegate = self
            present(viewController: vc, animated: true, completion: nil)
        case .more:
            break
        }
    }
}

// MARK: - ProfileViewControllerDelegate
extension PersonalCoordinator: ProfileViewControllerDelegate {
    func selectNext(vc: ProfileViewController) {
        vc.dismiss(animated: true)
    }
}

// MARK: - TestViewControllerDelegate
extension PersonalCoordinator: TestViewControllerDelegate {
    func selectNext(vc: TestViewController, answer: [QuestionDomainObject.Question]) {
        vc.dismiss(animated: true)
    }
}
