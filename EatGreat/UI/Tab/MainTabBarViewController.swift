//
//  MainTabBarViewController.swift
//  EatGreat
//
//  Created by Book on 2022/7/7.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let myPhysiqueCoordinator: MyPhysiqueCoordinator = .init()
    private let planCoordinator: PlanCoordinator = .init()
    private let personalCoordinator: PersonalCoordinator = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupAppearance()
        setTabBarItems()
    }
}


// MARK: - Private Function
extension MainTabBarViewController {
    private func setupViewControllers() {
        viewControllers = [
            myPhysiqueCoordinator.navigater,
            planCoordinator.navigater,
            personalCoordinator.navigater
        ]
    }

    private func setupAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.selectionIndicatorTintColor = .themePrimary
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        tabBar.isTranslucent = false
    }

    private func setTabBarItems() {
        let items: [UITabBarItem] = [
            .init(title: "我的體質",
                  image: UIImage(named: "TabIcon-MyPhysique"),
                  selectedImage: UIImage(named: "TabIcon-MyPhysique")),
            .init(title: "改善計畫",
                  image: UIImage(named: "TabIcon-Plan"),
                  selectedImage: UIImage(named: "TabIcon-Plan")),
            .init(title: "個人設定",
                  image: UIImage(named: "TabIcon-Personal"),
                  selectedImage: UIImage(named: "TabIcon-Personal"))
        ]

        for (index, item) in items.enumerated() {
            tabBar.items?[index].title = item.title
            tabBar.items?[index].image = item.image
            tabBar.items?[index].selectedImage = item.selectedImage
        }

        tabBar.barTintColor = .themePrimary
        tabBar.unselectedItemTintColor = .grey2
        tabBar.tintColor = .themePrimary
    }
}
