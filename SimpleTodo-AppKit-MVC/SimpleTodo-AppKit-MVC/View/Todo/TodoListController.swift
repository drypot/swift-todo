//
//  TodoListController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class TodoListController: NSViewController {

    let padding = 20.0

    let stackView = NSStackView()

    var homeControllerDelegate: HomeControllerDelegate!
    
    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        let textField = NSTextField(string: "...")
        stackView.addArrangedSubview(textField)

        let button1 = NSButton(title: "Button 1", target: self, action: #selector(button1Clicked))
        stackView.addArrangedSubview(button1)
    }

    @objc func button1Clicked(_ sender: NSButton) {
        print("button1 clicked")
    }

    
}
