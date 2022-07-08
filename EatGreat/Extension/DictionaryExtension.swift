//
//  DictionaryExtension.swift
//  newmoneybook
//
//  Created by BookSu on 2020/12/21.
//  Copyright © 2020 MoneyBook. All rights reserved.
//

import Foundation

extension Dictionary {
    var JSON: Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            return Data()
        }
    }
}
