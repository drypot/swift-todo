//
//  Todo.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

struct Todo: Identifiable, Equatable {

    typealias ID = UUID

    let id = ID()
    var subjectID: Subject.ID
    var createdAt = Date()
    var done = false
    var title = ""
}

