//
//  BaseViewController.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit

// MARK: - BaseViewController - The parent class for all view controller
class BaseViewController: UIViewController {
  override init(nibName nibNameOrNil: String?, bundle nibBundkeOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func commonInit() { }
  
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: imageName, withConfiguration: configuration)
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
  }
}
