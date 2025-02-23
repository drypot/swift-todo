//
//  Repository.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

class Repository {
    private(set) var subjects = [Subject]()
    private(set) var selectedSubject: Subject?
    private(set) var selectedTodo: Todo?

    var subjectSelected: Bool {
        return selectedSubject != nil
    }

    var todoSelected: Bool {
        return selectedTodo != nil
    }

    func load() {
        do {
            let subject = Subject(title: "Trip")
            subject.todos.append(Todo(title: "Buy ticket", subjectID: subject.id))
            subject.todos.append(Todo(title: "Book hotel", subjectID: subject.id))
            subject.todos.append(Todo(title: "Packing", subjectID: subject.id))
            subjects.append(subject)
        }
        do {
            let subject = Subject(title: "Shopping")
            subject.todos.append(Todo(title: "Goods 1", subjectID: subject.id))
            subject.todos.append(Todo(title: "Goods 2", subjectID: subject.id))
            subject.todos.append(Todo(title: "Goods 3", subjectID: subject.id))
            subjects.append(subject)
        }
        do {
            let subject = Subject(title: "Books")
            subject.todos.append(Todo(title: "Book 1", subjectID: subject.id))
            subject.todos.append(Todo(title: "Book 2", subjectID: subject.id))
            subject.todos.append(Todo(title: "Book 3", subjectID: subject.id))
            subjects.append(subject)
        }
    }

    func save() {
        print("repository: save not implemented")
    }

    func addNewSubject(withTitle title: String) {
        let subject = Subject(title: title)
        subject.todos.append(Todo(title: "Job 1", subjectID: subject.id))
        subject.todos.append(Todo(title: "Job 2", subjectID: subject.id))
        subject.todos.append(Todo(title: "Job 3", subjectID: subject.id))
        subjects.append(subject)
    }

    func removeSubject(at index: Array<Subject>.Index) {
        subjects.remove(at: index)
    }

    func selectSubject(at index: Array<Subject>.Index) {
        if subjects.indices.contains(index) {
            selectedSubject = subjects[index]
        } else {
            selectedSubject = nil
        }
    }

    func deselectSubject() {
        selectedSubject = nil
    }

    func addNewTodo(withTitle title: String) {
        guard let selectedSubject else { return }
        let todo = Todo(title: title, subjectID: selectedSubject.id)
        selectedSubject.todos.append(todo)
    }

    func removeTodo(at index: Array<Todo>.Index) {
        guard let selectedSubject else { return }
        selectedSubject.todos.remove(at: index)
    }

    func selectTodo(at index: Array<Subject>.Index) {
        guard let selectedSubject else { return }
        if selectedSubject.todos.indices.contains(index) {
            selectedTodo = selectedSubject.todos[index]
        } else {
            selectedTodo = nil
        }
    }

    func deselectTodo() {
        selectedTodo = nil
    }

    //    func deleteTodo(_ todo: Todo) {
    //        let (subjectIndex, todoIndex) = index(of: todo)
    //        subjects[subjectIndex].todos.remove(at: todoIndex)
    //    }
    //
    //    private func index(of todo: Todo) -> (subjectIndex: Array<Subject>.Index, todoIndex: Array<Todo>.Index) {
    //        guard let subjectIndex = subjects.firstIndex(where: { $0.id == todo.subjectID }) else {
    //            fatalError("Invalid subject.")
    //        }
    //        guard let todoIndex = subjects[subjectIndex].todos.firstIndex(where: { $0.id == todo.id }) else {
    //            fatalError("Invalid todo.")
    //        }
    //        return (subjectIndex, todoIndex)
    //    }

}


