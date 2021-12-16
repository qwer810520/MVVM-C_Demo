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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
        return label
    }()
    
    private var titleInputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var contentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Content: "
        return label
    }()
    
    private var contentInputView: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    private var saveBotton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: AddTodoNoteViewDelegate?
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        layer.cornerRadius = 10
        backgroundColor = .white
        addSubviews([titleLabel, titleInputTextField, contentTitleLabel, saveBotton, cancelButton, contentInputView])
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(45)
            $0.height.equalTo(40)
        }
        
        titleInputTextField.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(5)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(titleLabel.snp.top)
            $0.height.equalTo(titleLabel.snp.height)
        }
        
        contentTitleLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleInputTextField.snp.right)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
        }
        
        cancelButton.snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.right.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(50)
        }
        
        saveBotton.snp.makeConstraints {
            $0.left.equalTo(cancelButton.snp.right)
            $0.bottom.right.equalToSuperview()
            $0.height.equalTo(cancelButton.snp.height)
        }
        
        contentInputView.snp.makeConstraints {
            $0.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            $0.left.equalTo(contentTitleLabel.snp.left)
            $0.right.equalTo(contentTitleLabel.snp.right)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-15)
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
