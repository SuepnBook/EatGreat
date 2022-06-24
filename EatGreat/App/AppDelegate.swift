//
//  AppDelegate.swift
//  EatGreat
//
//  Created by Book on 2022/6/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var coordinator: AppCoordinator = {
        let coordinator = AppCoordinator(window: window)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.start()
        return true
    }

}

