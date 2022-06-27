//
//  BaseCoordinator.swift
//  Gozeppelin
//
//  Created by SUNG HAO LIN on 2021/12/17.
//

import Foundation
import UIKit

public class BaseCoordinator: Coordinator {
    public var children: [Coordinator] = []
    public var router: NavigationRouter
    public var navigater: UINavigationController {
        return router.navigationController
    }

    public init(router: NavigationRouter) {
        self.router = router
    }

    public func start() {}

    public func addChild(_ coordinator: Coordinator) {
        children.append(coordinator)
    }

    public func push(_ viewController: UIViewController, animated: Bool) {
        router.push(viewController, animated: animated)
        viewController.coordinator = self
    }

    public func pop(animated: Bool) {
        router.pop(animated: animated)
    }

    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.coordinator = self
        navigater.present(viewController, animated: animated, completion: completion)
    }
}

extension UIViewController {
    private enum CoordinatorAssociatedKeys {
        static var ownerKey: UInt = 0
    }

    weak var coordinator: Coordinator? {
        get {
            objc_getAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey) as? Coordinator
        }

        set {
            objc_setAssociatedObject(self, &CoordinatorAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
