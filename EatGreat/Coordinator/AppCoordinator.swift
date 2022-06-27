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
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        onboardingCoordinator = OnBoardingCoordinator()
        let startCoordinator = onboardingCoordinator
        self.window?.rootViewController = startCoordinator
        self.window?.makeKeyAndVisible()
    }
}
