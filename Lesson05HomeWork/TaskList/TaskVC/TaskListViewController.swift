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
    private var mainTaskHolder: [String: [TaskList]] = ["0": []]
    private var taskLevelKey: String = "0"
    private var previousTaskLevelKey: String = "0"
    private var nowPresentedTasks: [TaskList] = []
    private var pathCatcher: String = ""

    //MARK: - Cell properties
    private let taskCellIdentifier: String = "TaskCell"
    private let taskCellNibName: String = "TaskTableViewCell"
    
    //MARK: - ViewController Lifecycle
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
        return nowPresentedTasks.count
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
        cell.configureTaskNameLabel(taskNameLabelText: nowPresentedTasks[indexPath.row].name)
        cell.configureNumberOfNestedTasksLabel(numberOfNestedTasksLabelText: mainTaskHolder[taskLevelKey]?[indexPath.row].numberOfNestedTasks ?? 0)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backBarButtonItem.tintColor = .blue
        taskLevelKey = "\(taskLevelKey)\(indexPath.row)"
        print("taskLevelKey \(taskLevelKey)")

        if mainTaskHolder[taskLevelKey] == nil {
            nowPresentedTasks = []
        } else {
            guard let mainTaskHolderByTaskLevelKey = mainTaskHolder[taskLevelKey] else { return }
            nowPresentedTasks = mainTaskHolderByTaskLevelKey
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - @IBActions
    @IBAction func plusTaskButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField {(textField) in
            textField.placeholder = "Task Name"
        }
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self, weak alert] (action) in
            guard let firstText = alert?.textFields?.first?.text else { return }
            let task = Task(name: firstText)
            self?.addTask(newTask: task, taskLevelKey: self?.taskLevelKey ?? "0")
            print("addTask self?.taskLevelKey \(String(describing: self?.taskLevelKey))")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func addTask(newTask: Task, taskLevelKey: String) {
        guard !newTask.name.isEmpty else { return }
        if mainTaskHolder[taskLevelKey]?.count == nil {
            mainTaskHolder[taskLevelKey] = [newTask]
        } else {
            mainTaskHolder[taskLevelKey]?.append(newTask)
        }
        guard let mainTaskHolderByTaskLevelKey = mainTaskHolder[taskLevelKey] else { return }
        nowPresentedTasks = mainTaskHolderByTaskLevelKey
        tableView.reloadData()
    }
    
    func previousTaskLevelKeyCalculation(taskLevelKey: String) -> String {
        if taskLevelKey != "0" {
            previousTaskLevelKey = String(taskLevelKey.dropLast())
        }
        return previousTaskLevelKey
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if taskLevelKey != "0" {
            pathCatcher = String(taskLevelKey.dropFirst(taskLevelKey.count - 1))
            taskLevelKey = previousTaskLevelKeyCalculation(taskLevelKey: taskLevelKey)
            mainTaskHolder[taskLevelKey]?[Int(pathCatcher) ?? 0].numberOfNestedTasks = nowPresentedTasks.count
            guard let mainTaskHolderByTaskLevelKey = mainTaskHolder[taskLevelKey] else { return }
            nowPresentedTasks = mainTaskHolderByTaskLevelKey
            tableView.reloadData()
        }
        if taskLevelKey == "0" {
            backBarButtonItem.tintColor = .white
        }
    }
}
