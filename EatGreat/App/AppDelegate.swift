//
//  AppDelegate.swift
//  EatGreat
//
//  Created by Book on 2022/6/24.
//

import UIKit
import FirebaseCore
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var coordinator: AppCoordinator = {
        let coordinator = AppCoordinator(window: window)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupSDK()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.start()
        return true
    }
    
    private func setupSDK() {
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        FirebaseApp.configure()
        
        RealtimeDatabaseRepository.shared.fetchDB()
    }
}

