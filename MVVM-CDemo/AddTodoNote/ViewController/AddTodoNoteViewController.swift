//
//  AddTodoNoteViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

protocol AddTodoNoteViewControllerDelegate: AnyObject {
    func addTodoNoteViewController(_ viewController: AddTodoNoteViewController, editAction action: AddTodoNoteViewController.Actions)
}

class AddTodoNoteViewController: UIViewController {
    
    private lazy var editNewNoteView: AddTodoNoteView = {
        let view = AddTodoNoteView()
        view.delegate = self
        return view
    }()
    
    enum Actions {
        case cancel, finish(TodoNote)
    }
    
    weak var delegate: AddTodoNoteViewControllerDelegate?
    private let viewModel: AddTodoNoteViewModelType
    
    // MARK: - UIViewController
    
    init(viewModel: AddTodoNoteViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Privare Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.25)
        view.addSubview(editNewNoteView)
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        editNewNoteView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 100)
            $0.height.equalTo(500)
        }
    }
    
    private func setupBinding() {
        viewModel.output.finishTrigger.bind { [weak self] res in
            switch res {
            case let .success(newNote):
                self?.delegate?.addTodoNoteViewController(self!, editAction: .finish(newNote))
            case let .failure(error):
                self?.showAlert(with: error.errorDescription ?? "")
            }
        }
    }
}

    // MARK: - AddTodoNoteViewDelegate

extension AddTodoNoteViewController: AddTodoNoteViewDelegate {
    func cancelButtonDidPressed() {
        delegate?.addTodoNoteViewController(self, editAction: .cancel)
    }
    
    func saveButtonDidPressed(with inputTexts: (title: String, content: String)) {
        viewModel.input.createNewTodoNote(with: inputTexts.title, andContent: inputTexts.content)
    }
}

extension UIViewController {
    func showAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Check", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
