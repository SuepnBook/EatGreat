//
//  OnBoardingCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit

class OnBoardingCoordinator:UINavigationController {
    public init() {
//        let rootVC = OnBoardingViewController()
        let rootVC = TestViewController()
        super.init(rootViewController: rootVC)
//        rootVC.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - OnBoardingViewControllerDelegate
extension OnBoardingCoordinator:OnBoardingViewControllerDelegate {
    func selectStart(vc: OnBoardingViewController) {
        let vc = TestViewController()
        vc.delegate = self
        pushViewController(vc, animated: true)
    }
}

// MARK: - TestViewControllerDelegate
extension OnBoardingCoordinator:TestViewControllerDelegate {
    func selectNext(vc: TestViewController) {
        let vc = ProfileViewController()
        vc.delegate = self
        pushViewController(vc, animated: true)
    }
}

// MARK: - ProfileViewControllerDelegate
extension OnBoardingCoordinator:ProfileViewControllerDelegate {
    func selectNext(vc: ProfileViewController) {
        
    }
}
