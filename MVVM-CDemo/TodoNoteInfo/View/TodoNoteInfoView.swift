//
//  TodoNoteInfoView.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

class TodoNoteInfoView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var contentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Content: "
        return label
    }()
    
    private var contentTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    // MARK: - Initializaiton
    
    init() {
        super.init(frame: .zero)
        setupUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(with note: TodoNote) {
        titleLabel.text = "Title: \(note.title)"
        contentTextView.text = note.content
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        backgroundColor = .white
        addSubviews([titleLabel, contentTitleLabel, contentTextView])
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(40)
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
        }
        
        contentTextView.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }
}
