//
//  TodoTabbarController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UITabBarController

class TodoTabbarController: UITabBarController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            tabBar.standardAppearance = appearance
        }
    }
}

