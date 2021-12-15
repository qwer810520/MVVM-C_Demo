//
//  TodoNoteInfoCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

class TodoNoteInfoCoordinator: Coordinator<UINavigationController> {
    
    private let noteInfo: TodoNote
    
    init(viewController: UINavigationController, noteInfo: TodoNote) {
        self.noteInfo = noteInfo
        super.init(viewController: viewController)
    }
    
    override func start() {
        let controller = TodoNoteInfoViewController()
        controller.hidesBottomBarWhenPushed = true
        push(viewController: controller)
        super.start()
    }
}
