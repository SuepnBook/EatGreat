//
//  UIControlExtension.swift
//  Gozeppelin
//
//  Created by Book on 2021/6/7.
//

import RxCocoa
import RxSwift

extension UIControl {
    func rxControlEvent(controlEvents: Event = .touchUpInside,
                        dueTime: RxTimeInterval = .milliseconds(500)) -> Observable<Void> {
        rx.controlEvent(controlEvents)
            .throttle(dueTime, scheduler: MainScheduler.asyncInstance)
            .observe(on: MainScheduler.instance)
    }
}
