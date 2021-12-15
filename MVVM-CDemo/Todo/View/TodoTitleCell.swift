//
//  TodoTitleCell.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import SnapKit

class TodoTitleCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var bottomIntervalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        return view
    }()
    
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
        setupAutolayout()
    }
    
    private func setupAutolayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.lessThanOrEqualTo(200)
        }
        
        bottomIntervalLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
