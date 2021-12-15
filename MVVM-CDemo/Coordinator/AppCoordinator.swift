//
//  AppCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UITabBarController

class AppCoordinator: Coordinator<UITabBarController> {
    
    override func start() {
        let rootTabbar = RootTabbarCoordinator(viewController: rootViewController)
        rootTabbar.start()
        super.start()
    }
}
