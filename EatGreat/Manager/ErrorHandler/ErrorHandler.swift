//
//  ErrorHandler.swift
//  Gozeppelin
//
//  Created by Book on 2021/8/25.
//

import Foundation

class ErrorHandler {
    static func handle(error: Error) {
        ProgressManager.dismiss()

        switch error {
        case is SwiftError:
            handleSwiftError(error: error)
        default:
            handleDefaultError(error: error)
        }
    }

    private static func handleSwiftError(error: Error) {
        guard let error = error as? SwiftError else {
            return
        }

        ProgressManager.showErrorHUD(withStatus: error.errorMessage)
    }

    private static func handleDefaultError(error: Error) {
        let nsError = error as NSError
        ProgressManager.showErrorHUD(withStatus: nsError.domain)
    }
}
