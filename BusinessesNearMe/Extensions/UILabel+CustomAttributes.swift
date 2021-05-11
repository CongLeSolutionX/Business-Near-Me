//
//  UILabel+CustomAttributes.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import UIKit

// Configure UILabel init with pre-defined custom attributes
extension UILabel {
  func baseTextConfigure() {
      numberOfLines = 0
      adjustsFontSizeToFitWidth = true
      minimumScaleFactor = 0.1
  }
  
  func stylizeToCenter(alignment: NSTextAlignment = .center) {
    baseTextConfigure()
    textAlignment = alignment
  }
}
