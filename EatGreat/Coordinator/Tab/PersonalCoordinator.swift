//
//  PersonalCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class PersonalCoordinator: BaseCoordinator {
    init() {
        super.init(router: .init())
        start()
    }
    
    override func start() {
        let rootVC = PersonalViewController()
        push(rootVC, animated: true)
    }
}
