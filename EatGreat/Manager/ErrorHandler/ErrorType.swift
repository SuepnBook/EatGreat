//
//  ErrorType.swift
//  Gozeppelin
//
//  Created by Book on 2022/1/24.
//

import Foundation

enum SwiftError: Error {
    case strongSelf
    case errorMessage(message: String)
    case other

    public var errorDomain: String {
        switch self {
        case .strongSelf:
            return "Strong Self Error"
        case let .errorMessage(message: message):
            return "ErrorMessage" + message
        case .other:
            return "Other"
        }
    }

    public var errorMessage: String {
        switch self {
        case .strongSelf:
            return "Something went wrong. Please try again."
        case let .errorMessage(message: message):
            return message
        case .other:
            return "Something went wrong. Please try again."
        }
    }
}
