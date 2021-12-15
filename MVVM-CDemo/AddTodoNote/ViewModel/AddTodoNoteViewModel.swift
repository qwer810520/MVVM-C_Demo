//
//  AddTodoNoteViewModel.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import Foundation

protocol AddTodoNoteViewModelInput {
    func createNewTodoNote(with title: String, andContent content: String)
}

protocol AddTodoNoteViewModelOutput {
    var finishTrigger: Observable<Result<TodoNote, AddTodoNoteViewModel.Error>> { get }
}

protocol AddTodoNoteViewModelType {
    var input: AddTodoNoteViewModelInput { get }
    var output: AddTodoNoteViewModelOutput { get }
}

class AddTodoNoteViewModel: AddTodoNoteViewModelType, AddTodoNoteViewModelOutput {

    enum Error: LocalizedError {
        case titleIsEmpty
    }
    
    var input: AddTodoNoteViewModelInput { self }
    var output: AddTodoNoteViewModelOutput { self }
    
    private(set) var finishTrigger: Observable<Result<TodoNote, Error>> = Observable()
}

    // 

extension AddTodoNoteViewModel: AddTodoNoteViewModelInput {
    func createNewTodoNote(with title: String, andContent content: String) {
        guard !title.isEmpty else {
            output.finishTrigger.value = .failure(.titleIsEmpty)
            return
        }
        let newNode = TodoNote(title: title, content: content)
        output.finishTrigger.value = .success(newNode)
    }
}

extension AddTodoNoteViewModel.Error {
    var errorDescription: String? {
        return "Title is empty"
    }
}
