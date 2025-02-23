//
//  BlankController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/18/25.
//

import AppKit

class BlankController: NSViewController {

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupViews()
    }

    func setupViews() {
        let textField = NSTextField(string: "...")
        view.addSubview(textField)

        let button1 = NSButton(title: "Button 1", target: self, action: #selector(button1Clicked))
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            button1.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func button1Clicked(_ sender: NSButton) {
        print("button1 clicked")
    }

}
