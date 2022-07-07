//
//  MyPhysiqueCoordinator.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//

import UIKit

class MyPhysiqueCoordinator: BaseCoordinator {

    init() {
        super.init(router: .init())
        start()
    }
    
    override func start() {
        let rootVC = MyPhysiqueViewController()
        push(rootVC, animated: true)
    }
}
