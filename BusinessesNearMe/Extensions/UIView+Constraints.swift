//
//  UIView+Constraints.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit
extension UIView {
  // pre-define constraint to the superview
  func pin(to superView: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.topAnchor),
      leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor)
    ])
  }
}
