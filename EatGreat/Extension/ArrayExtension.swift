//
//  ArrayExtension.swift
//  EatGreat
//
//  Created by Book on 2022/6/28.
//

import Foundation

extension Array {
    func isOutOfRange(index: Int) -> Bool {
        index > self.count - 1
    }

    func isEnd(index: Int) -> Bool {
        index >= self.count - 1
    }
}
