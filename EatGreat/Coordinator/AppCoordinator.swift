//
//  AppCoordinator.swift
//  ClearEnv
//
//  Created by Book on 2022/4/18.
//

import UIKit

class AppCoordinator {
    
    private var window: UIWindow?
    
    private var onboardingCoordinator:OnBoardingCoordinator?
    private var tabBar:MainTabBarViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if UserDefaultManager.nickName != nil {
            showTabBar()
        } else {
            showOnboarding()
        }
        self.window?.makeKeyAndVisible()
    }
    
    func showOnboarding() {
        onboardingCoordinator = OnBoardingCoordinator()
        setRootModule(onboardingCoordinator)
    }
    
    func showTabBar() {
        tabBar = MainTabBarViewController()
        setRootModule(tabBar)
    }
    
    private func setRootModule(_ controller: UIViewController?) {
        guard let window = window else { return }
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
