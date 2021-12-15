//
//  AddTodoNoteCoordinator.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol AddTodoNoteCoordinatorDelegate: AnyObject {
    func addTodoNoteDidFinishEdit(_ coordinator: AddTodoNoteCoordinator, withNewNote note: TodoNote)
}

class AddTodoNoteCoordinator: Coordinator<UINavigationController> {
    
    weak var delegate: AddTodoNoteCoordinatorDelegate?
    
    override func start() {
        let controller = AddTodoNoteViewController()
        controller.delegate = self
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        present(viewController: controller)
        super.start()
    
    }
}

    // MARK: - AddTodoNoteViewControllerDelegate

extension AddTodoNoteCoordinator: AddTodoNoteViewControllerDelegate {
    func addTodoNoteViewController(_ viewController: AddTodoNoteViewController, didFinishEdit note: TodoNote) {
        delegate?.addTodoNoteDidFinishEdit(self, withNewNote: note)
        dismiss(animated: true)
    }
}
