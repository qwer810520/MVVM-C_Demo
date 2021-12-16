//
//  TodoViewModel.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import UIKit

protocol TodoViewModelInput {
    func setupNewTodoNote(withNote note: TodoNote)
}

protocol TodoViewModelOutput {
    var refreshDataTrigger: Observable<Void> { get }
    var todoNoteCount: Int { get }
    func findTodoNote(withIndex index: Int) -> TodoNote
}

protocol TodoViewModelType {
    var input: TodoViewModelInput { get }
    var output: TodoViewModelOutput { get }
}

class TodoViewModel: TodoViewModelType {
    
    let refreshDataTrigger: Observable<Void> = Observable()
    var input: TodoViewModelInput { self }
    var output: TodoViewModelOutput { self }
    
    private var todoNoteList: [TodoNote] = [TodoNote(title: "Demo1", content: "Test Test")] {
        didSet {
            refreshDataTrigger.value = ()
        }
    }
}

    // MARK: - TodoViewModelInput

extension TodoViewModel: TodoViewModelInput {
    func setupNewTodoNote(withNote note: TodoNote) {
        todoNoteList.append(note)
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
