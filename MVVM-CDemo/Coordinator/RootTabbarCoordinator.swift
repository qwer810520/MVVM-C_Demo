//
//  RootTabbarCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UITabBarController

class RootTabbarCoordinator: Coordinator<UITabBarController> {
    
    private let tabbarDelegateProxy = TodoTabbarDelegateProxy()
    private let navigationDelegateProxy = TodoNavigationDelegateProxy()
    private var selectCoordinator: CoordinatorType?
    
    override func start() {
        setupChildViewControllers()
        rootViewController.delegate = tabbarDelegateProxy
        tabbarDelegateProxy.delegate = self
        
        let firstTabCoordinator = childCoordinator[0]
        firstTabCoordinator.start()
        selectCoordinator = firstTabCoordinator
        super.start()
    }
}

extension RootTabbarCoordinator {
    private func setupChildViewControllers() {
        func makeNavigation() -> TodoNavigationController {
            let navigation = TodoNavigationController()
            navigation.delegate = navigationDelegateProxy
            return navigation
        }
        
        let todoNavigation = makeNavigation()
        todoNavigation.tabBarItem = UITabBarItem(title: "Todo", image: nil, tag: 0)
        let todoCoordinator = TodoCoordinator(viewController: todoNavigation)
        
        childCoordinator = [todoCoordinator]
        childCoordinator.forEach { $0.parent = self }
        rootViewController.viewControllers = [todoNavigation]
    }
}

    // MARK: - TodoTabbarDelegateProxyDelegate

extension RootTabbarCoordinator: TodoTabbarDelegateProxyDelegate {
    func todoTabbarDelegateProxy(_ proxy: TodoTabbarDelegateProxy, didSelect viewController: UIViewController) {
        // TODO
    }
}
