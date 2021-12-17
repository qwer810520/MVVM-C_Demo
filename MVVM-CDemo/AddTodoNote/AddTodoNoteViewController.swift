//
//  AddTodoNoteViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit
import Combine

protocol AddTodoNoteViewControllerDelegate: AnyObject {
    func addTodoNoteViewController(_ viewController: AddTodoNoteViewController, editAction action: AddTodoNoteViewController.Actions)
}

class AddTodoNoteViewController: UIViewController {
    
    enum Actions {
        case cancel, finish(TodoNote)
    }
    
    private let viewModel: AddTodoNoteViewModelType
    private var subscriptions: Set<AnyCancellable> = []
    private var editNewNoteView = AddTodoNoteView()
    weak var delegate: AddTodoNoteViewControllerDelegate?
    
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
        observerKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNotificationObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Privare Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.25)
        view.addSubview(editNewNoteView)
        setupSubviews()
        setupAutolayout()
    }

    private func setupSubviews() {
        editNewNoteView.delegate = self
    }
    
    private func setupAutolayout() {
        editNewNoteView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 100)
            $0.height.equalTo(400)
        }
    }
    
    private func setupBinding() {
        viewModel.output.finishTriggerPublisher
            .sink { [weak self] res in
                guard let self = self else { return }
                switch res {
                case let .finish(newNote):
                    self.delegate?.addTodoNoteViewController(self, editAction: .finish(newNote))
                case let .editFail(error):
                    self.showAlert(with: error.errorDescription ?? "")
                }
            }
            .store(in: &subscriptions)
    }
    
    private func observerKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Action Methods
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect, let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        let editViewFrame = editNewNoteView.frame
        
        guard keyboardFrame.minY - 20 < editViewFrame.maxY else { return }
        let space = (keyboardFrame.minY - editViewFrame.maxY) - 30
      
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0, options: [], animations: { [weak self] in
            self?.editNewNoteView.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(space)
            }
        })
    }
    
    @objc
    private func keyboardWillHide() {
        editNewNoteView.snp.updateConstraints {
            $0.centerY.equalToSuperview()
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
