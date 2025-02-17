//
//  Repository.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

class Repository {
    var subjects = [Subject]()

    func load() {
        do {
            var subject = Subject(title: "Trip")
            subject.todos.append(Todo(subjectID: subject.id, title: "Buy ticket"))
            subject.todos.append(Todo(subjectID: subject.id, title: "Book hotel"))
            subjects.append(subject)
        }
        do {
            var subject = Subject(title: "Shopping")
            subject.todos.append(Todo(subjectID: subject.id, title: "Goods 1"))
            subject.todos.append(Todo(subjectID: subject.id, title: "Goods 2"))
            subject.todos.append(Todo(subjectID: subject.id, title: "Goods 3"))
            subjects.append(subject)
        }
    }

    func save() {
        print("repository: save not implemented")
    }

    func updateTodo(_ todo: Todo) {
        let (subjectIndex, todoIndex) = index(of: todo)
        subjects[subjectIndex].todos[todoIndex] = todo
    }

    func deleteTodo(_ todo: Todo) {
        let (subjectIndex, todoIndex) = index(of: todo)
        subjects[subjectIndex].todos.remove(at: todoIndex)
    }

    private func index(of todo: Todo) -> (subjectIndex: Array<Subject>.Index, todoIndex: Array<Todo>.Index) {
        guard let subjectIndex = subjects.firstIndex(where: { $0.id == todo.subjectID }) else {
            fatalError("Invalid subject.")
        }
        guard let todoIndex = subjects[subjectIndex].todos.firstIndex(where: { $0.id == todo.id }) else {
            fatalError("Invalid todo.")
        }
        return (subjectIndex, todoIndex)
    }

}


