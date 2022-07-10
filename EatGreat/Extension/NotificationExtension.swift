//
//  NotificationExtension.swift
//  newmoneybook
//
//  Created by book_su on 2020/9/30.
//  Copyright © 2020 MoneyBook. All rights reserved.
//

import RxCocoa
import RxSwift

extension Notification {
    static func observable(names: [Notification.Name]) -> Observable<Notification> {
        var request: [Observable<Notification>] = []

        for name in names {
            let obser = NotificationCenter.default.rx.notification(name)
            request.append(obser)
        }

        let merge = Observable.merge(request)
        return merge
    }

    static func observable(name: Notification.Name) -> Observable<Notification> {
        NotificationCenter.default.rx.notification(name)
    }

    static func post(name: Notification.Name) {
        NotificationCenter.default.post(Notification(name: name))
    }

    static func post(name: Notification.Name, object: Any?) {
        NotificationCenter.default.post(name: name, object: object)
    }
}
