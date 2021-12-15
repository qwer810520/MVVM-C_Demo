//
//  Coordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit.UIViewController
import UIKit.UINavigationController

class Coordinator<T: UIViewController>: CoordinatorType {
    
    var childCoordinator: [CoordinatorType]
    var parent: CoordinatorType?
    let rootViewController: T
    
    private(set) var isStart = false
    private(set) var isActive = false
    
    init(viewController: T) {
        self.rootViewController = viewController
        self.childCoordinator = []
    }
    
    func start() {
        isStart = true
        isActive = true
    }
    
    func stop() {
        isStart = false
        isActive = false
        stopChildren()
    }
    
    final func startChild(_ coordinator: CoordinatorType) {
        guard !childCoordinator.contains(where: { $0 === coordinator }) else { return }
        coordinator.parent = self
        childCoordinator.append(coordinator)
        coordinator.start()
    }
    
    
    final func stopChild(_ coordinator: CoordinatorType) {
        coordinator.stop()
        if let index = childCoordinator.firstIndex(where: { $0 === coordinator }) {
            childCoordinator.remove(at: index)
        }
    }
    
    final func stopChildren() {
        childCoordinator.forEach {
            $0.stop()
        }
        childCoordinator.removeAll()
    }
    
    final func active() {
        isActive = true
        childCoordinator.forEach { $0.active() }
    }
    
    final func deactivate() {
        isActive = false
        childCoordinator.forEach { $0.deactivate() }
    }
}

    // MARK: - Present/Dismiss

extension Coordinator where T: UIViewController {
    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.coordinator = self
        rootViewController.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        var target: CoordinatorType?
        if let navigation = rootViewController.presentedViewController as? UINavigationController {
            target = navigation.viewControllers.first?.coordinator
        } else {
            target = self
        }
        
        rootViewController.dismiss(animated: animated) {
            if let target = target {
                self.parent?.stopChild(target)
            }
            completion?()
        }
    }
}

    // MARK: -  Push/Pop

extension Coordinator where T: UINavigationController {
    var coordinatorsAtNavigationController: [CoordinatorType] {
        rootViewController.viewControllers.compactMap { $0.coordinator }
    }
    
    func push(viewController: UIViewController, aninated: Bool = true) {
        viewController.coordinator = self
        guard !rootViewController.viewControllers.contains(viewController) else { return }
        rootViewController.pushViewController(viewController, animated: aninated)
    }
    
    func pop(animated: Bool = true) {
        rootViewController.popViewController(animated: animated)
    }
    
    func pop(to coordinator: CoordinatorType, animated: Bool = true) {
        guard let index = coordinatorsAtNavigationController.firstIndex(where: { $0 === coordinator }) else { return }
        let destinationVC = rootViewController.viewControllers[index]
        rootViewController.popToViewController(destinationVC, animated: animated)
    }
}
