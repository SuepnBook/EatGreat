//
//  PlanCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class PlanCoordinator: BaseCoordinator {
    init() {
        super.init(router: .init())
        start()
    }
    
    override func start() {
        let rootVC = PlanViewController()
        push(rootVC, animated: true)
    }
}
