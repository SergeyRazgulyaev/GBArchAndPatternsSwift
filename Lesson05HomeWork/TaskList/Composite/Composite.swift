//
//  Composite.swift
//  TaskList
//
//  Created by Sergey Razgulyaev on 15.11.2020.
//

import Foundation

protocol TaskList {
    var name: String { get set }
    var numberOfNestedTasks: Int { get set }
    var nestedTasks: [TaskList] { get set }
}

class Task: TaskList {
    var name: String
    var numberOfNestedTasks: Int = 0
    var nestedTasks: [TaskList] = []
    
    init(name: String) {
        self.name = name
    }
}


