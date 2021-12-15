//
//  CoordinatorType.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var childCoordinator: [CoordinatorType] { get set }
    var parent: CoordinatorType? { get set }
    
    func start()
    func startChild(_ coordinator: CoordinatorType)
    func active()
    
    func stop()
    func stopChild(_ coordinator: CoordinatorType)
    func stopChildren()
    func deactivate()
}

    // MARK: - UIViewController Extension

extension UIViewController {
    private struct coordinatorAssociatedObjectKeys {
        static var key: UInt = 0
    }
    
    weak var coordinator: CoordinatorType? {
        get { objc_getAssociatedObject(self, &coordinatorAssociatedObjectKeys.key) as? CoordinatorType }
        set { objc_setAssociatedObject(self, &coordinatorAssociatedObjectKeys.key, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}


