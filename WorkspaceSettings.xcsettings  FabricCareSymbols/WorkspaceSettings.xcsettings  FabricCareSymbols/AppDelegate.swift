//
//  AppDelegate.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    
    // View Controllers
    let mainVC = MainVC()
    let labelListVC = LabelListVC()
    
    let mainNaviVC = UINavigationController(rootViewController: mainVC)
    let labelListNaviVC = UINavigationController(rootViewController: labelListVC)
    
    // tabBar 구성
    let tabBarVC = UITabBarController()
    mainNaviVC.tabBarItem = UITabBarItem(title: "My Clothset", image: UIImage(systemName: "person.circle.fill") , tag: 0)
    labelListNaviVC.tabBarItem = UITabBarItem(title: "Laundly Label", image: UIImage(systemName: "info.circle.fill") , tag: 1)
    tabBarVC.viewControllers = [mainNaviVC,labelListNaviVC]

    
    window?.rootViewController = tabBarVC
    window?.makeKeyAndVisible()
    
    return true
  }

}

