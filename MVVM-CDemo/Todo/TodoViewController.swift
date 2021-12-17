//
//  TodoViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import Combine

struct TodoNote {
    var title: String
    var content: String
}

protocol TodoViewControllerDelegate: AnyObject {
    func todoViewController(_ viewController: TodoViewController, didTapAction action: TodoViewController.Actions)
}

class TodoViewController: UIViewController {
    
    enum Actions {
        case add, oldNote(TodoNote)
    }
    
    private let viewModel: TodoViewModelType
    private var subscriptions: Set<AnyCancellable> = []
    private lazy var todoCollectionView = createCollectionView()
    weak var delegate: TodoViewControllerDelegate?
    
    init(viewModel: TodoViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    func setupNewTodoNote(_ note: TodoNote) {
        viewModel.input.setupNewTodoNote(withNote: note)
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        navigationItem.title = "Todo"
        view.addSubview(todoCollectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemDidPressed))
        setupAutolayout()
        setupBinding()
    }
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(with: [TodoTitleCell.self])
        return collectionView
    }
    
    
    private func setupAutolayout() {
        todoCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        viewModel.output.refreshDataTrigger
            .sink { [weak self] res in
                switch res {
                case .reloadData:
                    self?.todoCollectionView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Action Methods
    
    @objc
    private func addItemDidPressed() {
        delegate?.todoViewController(self, didTapAction: .add)
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension TodoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note = viewModel.output.findTodoNote(withIndex: indexPath.item)
        delegate?.todoViewController(self, didTapAction: .oldNote(note))
    }
}

    // MARK: - UICollectionViewDataSource

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.todoNoteCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TodoTitleCell.self, for: indexPath)
        let item = viewModel.output.findTodoNote(withIndex: indexPath.item)
        cell.titleText = item.title
        return cell
    }
}

