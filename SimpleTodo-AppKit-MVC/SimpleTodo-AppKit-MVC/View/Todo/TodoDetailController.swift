//
//  TodoDetailController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class TodoDetailController: NSViewController {

    var repository: Repository!
    var homeController: HomeControllerProtocol!

    let todoTitle = NSTextField(labelWithString: "...")
    let todoDetail = NSTextView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupFields()
    }

    func setupFields() {
        todoTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoTitle)

        todoDetail.translatesAutoresizingMaskIntoConstraints = false
        todoDetail.string = "..."
        todoDetail.drawsBackground = false
        view.addSubview(todoDetail)

        NSLayoutConstraint.activate([
            todoTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            todoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            todoDetail.topAnchor.constraint(equalTo: todoTitle.bottomAnchor, constant: 20),
            todoDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todoDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            todoDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    func reloadData() {
        todoTitle.stringValue = repository.selectedTodo?.title ?? "..."
    }

}
