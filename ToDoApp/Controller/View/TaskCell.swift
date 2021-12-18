//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 16.12.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
            
                let dateString = dateFormatter.string(from: task.date)
                dateLabel.text = dateString
            
            
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
            
        }
        
    }
}
