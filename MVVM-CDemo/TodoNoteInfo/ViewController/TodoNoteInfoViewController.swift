//
//  TodoNoteInfoViewController.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

class TodoNoteInfoViewController: UIViewController {
    
    private var showTodoInfoView: TodoNoteInfoView = {
       return TodoNoteInfoView()
    }()
    
    private var noteInfo: TodoNote
    
    // MARK: - UIViewController
    
    init(info: TodoNote) {
        self.noteInfo = info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInterface()
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        navigationItem.title = "Todo Note"
        view.backgroundColor = .white
        view.addSubviews([showTodoInfoView])
        setupAutolayout()
        
        showTodoInfoView.setupData(with: noteInfo)
    }
    
    private func setupAutolayout() {
        showTodoInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
