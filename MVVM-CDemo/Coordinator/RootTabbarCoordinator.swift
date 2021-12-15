//
//  RootTabbarCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UITabBarController

class RootTabbarCoordinator: Coordinator<UITabBarController> {
    
    private let tabbarDelegateProxy = TodoTabbarDelegateProxy()
    
    override func start() {
        setupChildViewControllers()
        rootViewController.delegate = tabbarDelegateProxy
        tabbarDelegateProxy.delegate = self
        super.start()
    }
}

extension RootTabbarCoordinator {
    private func setupChildViewControllers() {
        
    }
}

    // MARK: - TodoTabbarDelegateProxyDelegate

extension RootTabbarCoordinator: TodoTabbarDelegateProxyDelegate {
    func todoTabbarDelegateProxy(_ proxy: TodoTabbarDelegateProxy, didSelect viewController: UIViewController) {
        print(#function)
    }
}
