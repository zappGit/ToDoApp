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
    let date: Date
    let location: Location?
    
    
    init (title: String,
          date: Date? = nil,
         description: String? = nil,
         location: Location? = nil) {
        self.title = title
        self.date = date ?? Date()
        self.description = description
        self.location = location
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
