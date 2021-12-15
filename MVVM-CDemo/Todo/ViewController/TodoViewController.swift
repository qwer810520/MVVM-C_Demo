//
//  TodoViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

struct TodoNote {
    var title: String
    var detail: String
}

protocol TodoViewControllerDelegate: AnyObject {
    func todoViewController(_ viewController: TodoViewController, didTapAction action: TodoViewController.Actions)
}

class TodoViewController: UIViewController {
    
    private lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(with: [TodoTitleCell.self])
        return collectionView
    }()
    
    enum Actions {
        case add, oldNote(TodoNote)
    }
    
    weak var delegate: TodoViewControllerDelegate?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        view.backgroundColor = .white
        navigationItem.title = "Todo"
        view.addSubview(todoCollectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemDidPressed))
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        todoCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func addItemDidPressed() {
        delegate?.todoViewController(self, didTapAction: .add)
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension TodoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note = TodoNote(title: "", detail: "")
        delegate?.todoViewController(self, didTapAction: .oldNote(note))
    }
}

    // MARK: - UICollectionViewDataSource

extension TodoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TodoTitleCell.self, for: indexPath)
        cell.titleText = "indexPath: \(indexPath.item)"
        return cell
    }
}

