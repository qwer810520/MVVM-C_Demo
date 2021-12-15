//
//  AddTodoNoteViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol AddTodoNoteViewControllerDelegate: AnyObject {
    func addTodoNoteViewController(_ viewController: AddTodoNoteViewController, didFinishEdit note: TodoNote)
}

class AddTodoNoteViewController: UIViewController {
    
    weak var delegate: AddTodoNoteViewControllerDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.addTodoNoteViewController(self, didFinishEdit: TodoNote(title: "", detail: ""))
    }
    
    // MARK: - Privare Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.25)
    }
}
