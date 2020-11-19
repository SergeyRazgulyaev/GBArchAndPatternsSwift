//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by Sergey Razgulyaev on 15.11.2020.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var nestedTaskLabel: UILabel!
    @IBOutlet private weak var numberOfNestedTasksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureTaskNameLabel(taskNameLabelText: String) {
        taskNameLabel.text = taskNameLabelText
    }
    
    func configureNumberOfNestedTasksLabel(numberOfNestedTasksLabelText: Int) {
        numberOfNestedTasksLabel.text = String(numberOfNestedTasksLabelText)
    }
}
