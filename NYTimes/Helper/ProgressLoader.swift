//
//  ProgressLoader.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ProgressLoader: NSObject {

    static func show() {
        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: .ballClipRotatePulse, color: UIColor.label, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    static func dismiss() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
