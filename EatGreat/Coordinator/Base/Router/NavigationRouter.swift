//
//  NavigationRouter.swift
//  Gozeppelin
//
//  Created by SUNG HAO LIN on 2021/12/16.
//

import UIKit

public class NavigationRouter: NSObject {
    public let navigationController: UINavigationController
    private let rootController: UIViewController?

    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.rootController = navigationController.viewControllers.first
        super.init()
        self.navigationController.delegate = self
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.pushViewController(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool) {
        guard let _ = rootController else {
            navigationController.popToRootViewController(animated: animated)
            return
        }

        navigationController.popViewController(animated: animated)
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let dismissedVieController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedVieController),
              let dismissedCoordinator = dismissedVieController.coordinator else {
            return
        }

        viewController.coordinator?.removeChild(child: dismissedCoordinator)
    }
}
