//
//  Todo.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

class Todo: Identifiable {

    typealias ID = UUID

    let id: ID
    var subjectID: Subject.ID
    var title: String
    var createdAt: Date
    var done: Bool

    init(title: String = "", subjectID: Subject.ID) {
        self.id = ID()
        self.subjectID = subjectID
        self.title = title
        self.createdAt = Date()
        self.done = false
    }

}

