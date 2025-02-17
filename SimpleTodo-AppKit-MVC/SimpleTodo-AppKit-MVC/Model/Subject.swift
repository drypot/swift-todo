//
//  Subject.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import Foundation

struct Subject: Identifiable, Equatable {

    typealias ID = UUID

    let id = ID()
    var createdAt = Date()
    var title = ""
    var todos = [Todo]()
}
