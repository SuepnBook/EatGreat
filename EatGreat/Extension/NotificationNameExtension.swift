//
//  NotificationNameExtension.swift
//  Gozeppelin
//
//  Created by Book on 2021/7/18.
//

import Foundation

extension Notification.Name {
    static var applicationWillEnterForeground: Notification.Name = .init(rawValue: "applicationWillEnterForeground")
    static var applicationDidEnterBackground: Notification.Name = .init(rawValue: "applicationDidEnterBackground")
}

// MARK: - Profile
extension Notification.Name {
    static var symptomRefresh: Notification.Name = .init(rawValue: "symptomRefresh")
    static var profileRefresh: Notification.Name = .init(rawValue: "profileRefresh")
}

