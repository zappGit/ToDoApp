//
//  Task.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 11.12.2021.
//

import Foundation

struct Task {
    var title: String
    var description: String?
    private(set) var date: Date?
    let location: Location?
    
    
    init (title: String,
         description: String? = nil,
         location: Location? = nil) {
        self.title = title
        self.description = description
        self.location = location
        self.date = Date()
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location {
            return true
        }
        return false
    }
}
