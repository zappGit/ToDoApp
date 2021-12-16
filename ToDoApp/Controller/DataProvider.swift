//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 16.12.2021.
//

import Foundation
import UIKit

enum Section: Int {
    case todo
    case done
}

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError() }
        guard let taskManager = taskManager else { return 0 }
        switch section {
    case .todo:
        return taskManager.taskCount
    case .done:
        return taskManager.doneTaskCount
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return TaskCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
