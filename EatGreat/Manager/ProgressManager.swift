//
//  ProgressManager.swift
//  Gozeppelin
//
//  Created by book_su on 2020/2/4.
//  Copyright © 2020 Gozeppelin. All rights reserved.
//

import ProgressHUD

class ProgressManager: NSObject {
    class func dismiss() {
        ProgressHUD.dismiss()
    }

    class func showPressHUD() {
        ProgressHUD.animationType = .circleRotateChase
//        ProgressHUD.setBackgroundLayerColor(UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.1))
//        ProgressHUD.setDefaultMaskType(.custom)
        ProgressHUD.show()
    }

    class func showErrorHUD(withStatus: String? = "Something went wrong. Please try again.",time: TimeInterval = 1) {
        ProgressHUD.dismiss()
        ProgressHUD.showError(withStatus, interaction: true)
    }

    class func showSuccessHUD(withStatus: String?) {
        ProgressHUD.dismiss()
        ProgressHUD.showSucceed()
    }


    class func showHUD(withStatus: String?) {
        ProgressHUD.dismiss()
//        ProgressHUD.setDefaultMaskType(type)
        ProgressHUD.show(withStatus)
    }

    class func showProgress(progress: Float) {
        ProgressHUD.dismiss()
        
        ProgressHUD.showProgress(CGFloat(progress))
    }
}
