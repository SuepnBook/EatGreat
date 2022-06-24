//
//  AppCoordinator.swift
//  ClearEnv
//
//  Created by Book on 2022/4/18.
//

import UIKit

class AppCoordinator {
    
    private var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}
