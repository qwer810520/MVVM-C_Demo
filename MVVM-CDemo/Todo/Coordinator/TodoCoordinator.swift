//
//  TodoCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

class TodoCoordinator: Coordinator<UINavigationController> {
    override func start() {
        let controller = TodoViewController()
        controller.delegate = self
        push(viewController: controller)
        super.start()
    }
}

    //MARK: - TodoViewControllerDelegate

extension TodoCoordinator: TodoViewControllerDelegate {
    func todoViewController(_ viewController: TodoViewController, didTapAction action: TodoViewController.Actions) {
        switch action {
        case .add:
            let addTodoCoordinator = AddTodoNoteCoordinator(viewController: rootViewController)
            addTodoCoordinator.delegate = self
            startChild(addTodoCoordinator)
        case let .oldNote(note):
            let todoNoteInfoCoordinator = TodoNoteInfoCoordinator(viewController: rootViewController, noteInfo: note)
            startChild(todoNoteInfoCoordinator)
        }
    }
}

    // MARK: - AddTodoNoteCoordinatorDelegate

extension TodoCoordinator: AddTodoNoteCoordinatorDelegate {
    func addTodoNoteDidFinishEdit(_ coordinator: AddTodoNoteCoordinator, withNewNote note: TodoNote) {
        
    }
}
