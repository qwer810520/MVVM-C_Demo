//
//  TodoViewModel.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit
import Combine

protocol TodoViewModelInput {
    func setupNewTodoNote(withNote note: TodoNote)
}

protocol TodoViewModelOutput {
    var refreshDataTrigger: AnyPublisher<TodoViewModel.ViewState, Never> { get }
    var todoNoteCount: Int { get }
    func findTodoNote(withIndex index: Int) -> TodoNote
}

protocol TodoViewModelType {
    var input: TodoViewModelInput { get }
    var output: TodoViewModelOutput { get }
}

class TodoViewModel: TodoViewModelType {
    
    enum ViewState {
        case reloadData
    }
    
    private let refreshDataTriggerSubjecy = CurrentValueSubject<ViewState, Never>(.reloadData)
    let refreshDataTrigger: AnyPublisher<ViewState, Never>
    var input: TodoViewModelInput { self }
    var output: TodoViewModelOutput { self }
    
    private var todoNoteList: [TodoNote] = [TodoNote(title: "Demo1", content: "Test Test")]
    
    init() {
        refreshDataTrigger = refreshDataTriggerSubjecy.eraseToAnyPublisher()
    }
}

    // MARK: - TodoViewModelInput

extension TodoViewModel: TodoViewModelInput {
    func setupNewTodoNote(withNote note: TodoNote) {
        todoNoteList.append(note)
        refreshDataTriggerSubjecy.send(.reloadData)
    }
}

    // MARK: - TodoViewModelOutput

extension TodoViewModel: TodoViewModelOutput {
    func findTodoNote(withIndex index: Int) -> TodoNote {
        return todoNoteList[index]
    }
    
    var todoNoteCount: Int {
        return todoNoteList.count
    }
}
