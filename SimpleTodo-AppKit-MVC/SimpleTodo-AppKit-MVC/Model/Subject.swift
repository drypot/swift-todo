//
//  Subject.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

class Subject: Identifiable {

    typealias ID = UUID

    let id: ID
    var title: String
    var createdAt: Date
    var todos: [Todo]

    init(title: String = "") {
        self.id = ID()
        self.createdAt = Date()
        self.title = title
        self.todos = [Todo]()
    }
}
