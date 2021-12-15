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
        let viewModel = AddTodoNoteViewModel()
        let controller = AddTodoNoteViewController(viewModel: viewModel)
        controller.delegate = self
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        present(viewController: controller)
        super.start()
    }
}

    // MARK: - AddTodoNoteViewControllerDelegate

extension AddTodoNoteCoordinator: AddTodoNoteViewControllerDelegate {
    func addTodoNoteViewController(_ viewController: AddTodoNoteViewController, editAction action: AddTodoNoteViewController.Actions) {
        switch action {
        case let .finish(newNote):
            delegate?.addTodoNoteDidFinishEdit(self, withNewNote: newNote)
        default:
            break
        }
        dismiss(animated: true)
    }
}
