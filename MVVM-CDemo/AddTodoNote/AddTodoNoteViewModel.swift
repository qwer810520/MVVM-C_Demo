//
//  AddTodoNoteViewModel.swift
//  MVVM-CDemo
//
//  Created by Min on 2021/12/15.
//

import Foundation
import Combine

protocol AddTodoNoteViewModelInput {
    func createNewTodoNote(with title: String, andContent content: String)
}

protocol AddTodoNoteViewModelOutput {
    var finishTriggerPublisher: AnyPublisher<AddTodoNoteViewModel.ViewState, Never> { get }
}

protocol AddTodoNoteViewModelType {
    var input: AddTodoNoteViewModelInput { get }
    var output: AddTodoNoteViewModelOutput { get }
}

class AddTodoNoteViewModel: AddTodoNoteViewModelType, AddTodoNoteViewModelOutput {
    enum Error: LocalizedError {
        case titleIsEmpty
    }
    
    enum ViewState {
        case finish(TodoNote), editFail(Error)
    }
    
    private var triggerSubject = PassthroughSubject<ViewState, Never>()
    private var subscriptions: Set<AnyCancellable> = []
    let finishTriggerPublisher: AnyPublisher<ViewState, Never>
    var input: AddTodoNoteViewModelInput { self }
    var output: AddTodoNoteViewModelOutput { self }
    
    init() {
        finishTriggerPublisher = triggerSubject.eraseToAnyPublisher()
    }
}

    // MARK: - AddTodoNoteViewModelInput

extension AddTodoNoteViewModel: AddTodoNoteViewModelInput {
    func createNewTodoNote(with title: String, andContent content: String) {
        guard !title.isEmpty else {
            triggerSubject.send(.editFail(.titleIsEmpty))
            return
        }
        let newNode = TodoNote(title: title, content: content)
        triggerSubject.send(.finish(newNode))
    }
}

extension AddTodoNoteViewModel.Error {
    var errorDescription: String? {
        return "Title is empty"
    }
}
