//
//  AppDelegate.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/10/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var navController: UINavigationController?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    let mapVC = MapViewController()
    let searchVC = SearchViewController()
    
    let searchNavController = UINavigationController(rootViewController: searchVC)
    let mapNavController = UINavigationController(rootViewController: mapVC)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [searchNavController, mapNavController]
    
    window?.rootViewController = tabBarController
    
    return true
  }
}



