//
//  ViewModelType.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
