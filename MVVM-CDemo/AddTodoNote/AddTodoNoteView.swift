//
//  AddTodoNoteViewView.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

protocol AddTodoNoteViewDelegate: AnyObject {
    func cancelButtonDidPressed()
    func saveButtonDidPressed(with inputTexts: (title: String, content: String))
}

class AddTodoNoteView: UIView {
    
    private var titleLabel = UILabel()
    private var titleInputTextField = UITextField()
    private var contentTitleLabel = UILabel()
    private var contentInputView = UITextView()
    private var saveBotton = UIButton()
    private var cancelButton = UIButton()
    
    weak var delegate: AddTodoNoteViewDelegate?
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - UI

extension AddTodoNoteView {
    private func setupUserInterface() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addSubviews([titleLabel, titleInputTextField, contentTitleLabel, saveBotton, cancelButton, contentInputView])
        setupSubViews()
        setupAutolayout()
    }
    
    private func setupSubViews() {
        titleLabel.text = "Title: "
        
        titleInputTextField.borderStyle = .roundedRect
        
        contentTitleLabel.text = "Content: "
        
        contentInputView.layer.cornerRadius = 5
        contentInputView.layer.borderWidth = 1
        contentInputView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        contentInputView.font = .systemFont(ofSize: 18)
        
        saveBotton.setTitle("Save", for: .normal)
        saveBotton.setTitleColor(.systemBlue, for: .normal)
        saveBotton.addTarget(self, action: #selector(saveButtonDidPressed), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidPressed), for: .touchUpInside)
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(45)
            make.height.equalTo(40)
        }
        
        titleInputTextField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.top)
            make.height.equalTo(titleLabel.snp.height)
        }
        
        contentTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleInputTextField.snp.right)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
        
        saveBotton.snp.makeConstraints { make in
            make.left.equalTo(cancelButton.snp.right)
            make.bottom.right.equalToSuperview()
            make.height.equalTo(cancelButton.snp.height)
        }
        
        contentInputView.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(contentTitleLabel.snp.left)
            make.right.equalTo(contentTitleLabel.snp.right)
            make.bottom.equalTo(cancelButton.snp.top).offset(-15)
        }
    }
    
    // MARK: - Action Methods
    
    @objc
    private func saveButtonDidPressed() {
        guard let title = titleInputTextField.text, let content = contentInputView.text else { return }
        delegate?.saveButtonDidPressed(with: (title, content))
    }
    
    @objc
    private func cancelButtonDidPressed() {
        delegate?.cancelButtonDidPressed()
    }
}
