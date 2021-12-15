//
//  TodoNavigationDelegateProxy.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UINavigationController

class TodoNavigationDelegateProxy: NSObject { }

    // MARK: - UINavigationControllerDelegate

extension TodoNavigationDelegateProxy: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousViewController) else { return }
        viewController.coordinator?.stopChildren()
    }
}
