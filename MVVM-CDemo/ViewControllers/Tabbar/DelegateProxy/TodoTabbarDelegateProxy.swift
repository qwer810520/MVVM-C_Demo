//
//  TodoTabbarDelegateProxy.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol TodoTabbarDelegateProxyDelegate: AnyObject {
    func todoTabbarDelegateProxy(_ proxy: TodoTabbarDelegateProxy, didSelect viewController: UIViewController)
}

class TodoTabbarDelegateProxy: NSObject {
    weak var delegate: TodoTabbarDelegateProxyDelegate?
}

    // MARK: - UITabBarControllerDelegate

extension TodoTabbarDelegateProxy: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        delegate?.todoTabbarDelegateProxy(self, didSelect: viewController)
    }
}
