//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Sergey Razgulyaev on 15.11.2020.
//

import UIKit

class TaskListViewController: UITableViewController {
    @IBOutlet private weak var taskName: UILabel!
    @IBOutlet private weak var numberOfNestedTasks: UILabel!
    @IBOutlet weak var backBarButtonItem: UIBarButtonItem!
    
    //MARK: - Base properties
    private var mainTaskHolder: [String: [Task]] = ["0":[Task(name: "initial")]]
    private var keyOfTask = "0"
    private var taskHolder: [Task] = [Task(name: "Root")]
    private var previousPresentedTasks: [Task] = [Task(name: "initial")]
    private var nowPresentedTasks: [Task] = [Task(name: "initial")]
    private var nextPresentedTasks: [Task] = [Task(name: "initial")]
    
    //MARK: - Cell properties
    private let taskCellIdentifier = "TaskCell"
    private let taskCellNibName = "TaskTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        tableView.register(UINib(nibName: taskCellNibName, bundle: nil), forCellReuseIdentifier: taskCellIdentifier)
        backBarButtonItem.tintColor = .white
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowPresentedTasks[0].nestedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureNewsCell(indexPath: indexPath)
    }
    
    func configureNewsCell(indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: taskCellIdentifier, for: indexPath) as? TaskTableViewCell
        guard let cell = taskCell else {
            print("Error with News Cell")
            return UITableViewCell()
        }
        
        cell.configureTaskNameLabel(taskNameLabelText: nowPresentedTasks[0].nestedTasks[indexPath.row].name)
        if nextPresentedTasks.count == 0 {
            cell.configureNumberOfNestedTasksLabel(numberOfNestedTasksLabelText: 0)
        } else {
            cell.configureNumberOfNestedTasksLabel(numberOfNestedTasksLabelText: nextPresentedTasks[0].nestedTasks.count)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backBarButtonItem.tintColor = .blue
        mainTaskHolder[keyOfTask] = nowPresentedTasks
        previousPresentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
        keyOfTask = "\(keyOfTask)\(indexPath.row)"
        
        if mainTaskHolder[keyOfTask]?.count == nil {
            mainTaskHolder[keyOfTask] = nextPresentedTasks
            nextPresentedTasks[0].name = ""
            nextPresentedTasks[0].numberOfNestedTasks = 0
            nextPresentedTasks[0].nestedTasks = []
            nowPresentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
            taskHolder = [Task(name: "empty")]
            taskHolder[0].nestedTasks = []
        } else {
            nowPresentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
            taskHolder = [Task(name: "empty")]
            taskHolder[0].nestedTasks = []
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @IBAction func plusTaskButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField {(textField) in
            textField.placeholder = "Task Name"
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self, weak alert] (action) in
            guard let firstText = alert?.textFields?.first?.text else { return }
            let task = Task(name: firstText)
            self?.addTask(newTask: task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func addTask(newTask: Task) {
        guard !newTask.name.isEmpty else { return }
        taskHolder[0].nestedTasks.append(newTask)
        taskHolder[0].numberOfNestedTasks = taskHolder[0].nestedTasks.count
        nowPresentedTasks = taskHolder
        tableView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if keyOfTask != "0" {
            mainTaskHolder[keyOfTask] = nowPresentedTasks
            nextPresentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
            keyOfTask = String(keyOfTask.dropLast())
            nowPresentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
            tableView.reloadData()
        }
        if keyOfTask == "0" {
            backBarButtonItem.tintColor = .white
        }
    }
}
