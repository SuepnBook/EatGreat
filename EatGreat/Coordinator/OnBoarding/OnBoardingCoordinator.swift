//
//  OnBoardingCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import UIKit

class OnBoardingCoordinator:UINavigationController {
    public init() {
        let rootVC = OnBoardingViewController()
        super.init(rootViewController: rootVC)
        rootVC.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingCoordinator:OnBoardingViewControllerDelegate {
    func selectStart(vc: OnBoardingViewController) {
        
    }
}
