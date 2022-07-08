//
//  DataSnapshotExtension.swift
//  newmoneybook
//
//  Created by BookSu on 2020/12/21.
//  Copyright © 2020 MoneyBook. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
    var valueToJSON: Data {
        guard let dic = value as? [String: Any] else {
            return Data()
        }
        return dic.JSON
    }

    var listToJSON: Data {
        guard let object = children.allObjects as? [DataSnapshot] else { return Data() }

        let dic: [NSDictionary] = object.compactMap { $0.value as? NSDictionary }

        do {
            return try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}
