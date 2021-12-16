//
//  TodoTitleCell.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

class TodoTitleCell: UICollectionViewCell {
    
    private var titleLabel = UILabel ()
    private var bottomIntervalLine = UIView()
    
    var titleText: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUserInterface() {
        contentView.addSubviews([titleLabel, bottomIntervalLine])
        setupSubViews()
        setupAutolayout()
    }
    
    private func setupSubViews() {
        bottomIntervalLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.lessThanOrEqualTo(200)
        }
        
        bottomIntervalLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
