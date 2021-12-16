//
//  TodoNoteInfoView.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

class TodoNoteInfoView: UIView {
    
    private var titleLabel = UILabel()
    private var contentTitleLabel = UILabel()
    private var contentTextView = UITextView()
    
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
        setupSubviews()
        addSubviews([titleLabel, contentTitleLabel, contentTextView])
        setupAutolayout()
    }
    
    private func setupSubviews() {
        contentTitleLabel.text = "Content: "
        
        contentTextView.isEditable = false
        contentTextView.font = .systemFont(ofSize: 18)
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        contentTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
