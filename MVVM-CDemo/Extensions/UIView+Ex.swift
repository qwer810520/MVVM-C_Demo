//
//  UIView+Ex.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
