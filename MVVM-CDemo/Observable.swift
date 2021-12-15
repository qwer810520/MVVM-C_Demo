//
//  Observable.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T? {
        didSet {
            guard let value = value else { return }
            listener?(value)
        }
    }
    
    init() {
        self.value = nil
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        if let value = value {
            closure(value)
        }
        listener = closure
    }
}
