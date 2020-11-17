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
    //    private var taskHolder: [[TaskList]] = []
    private var mainTaskHolder: [String: [Task]] = ["0":[]]
    private var keyOfTask = "0"
    private var taskHolder: [Task] = [Task(name: "Root")]
    private var nextPresentTasks: [Task] = [Task(name: "")]
    
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
        return nextPresentTasks[0].nestedTasks.count
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
        
        cell.configureTaskNameLabel(taskNameLabelText: nextPresentTasks[0].nestedTasks[indexPath.row].name)
        cell.configureNumberOfNestedTasksLabel(numberOfNestedTasksLabelText: nextPresentTasks[0].nestedTasks[indexPath.row].numberOfNestedTasks)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backBarButtonItem.tintColor = .blue
        mainTaskHolder[keyOfTask] = nextPresentTasks
        print("saved")
        print("keyOfTask \(keyOfTask)")
        print("mainTaskHolder[keyOfTask].name \(String(describing: mainTaskHolder[keyOfTask]?[0].name))")
        print("mainTaskHolder[keyOfTask].numberOfNestedTasks \(String(describing: mainTaskHolder[keyOfTask]?[0].numberOfNestedTasks))")
        print("mainTaskHolder[keyOfTask].nestedTasks.count \(String(describing: mainTaskHolder[keyOfTask]?[0].nestedTasks.count))\n")
        
        keyOfTask = "\(keyOfTask)\(indexPath.row)"
        nextPresentTasks[0].name = taskHolder[0].nestedTasks[indexPath.row].name
        nextPresentTasks[0].numberOfNestedTasks = 0
        nextPresentTasks[0].nestedTasks = []
        mainTaskHolder[keyOfTask] = nextPresentTasks

        print("\n new")
        print("keyOfTask \(keyOfTask)")
        print("mainTaskHolder[keyOfTask].name \(String(describing: mainTaskHolder[keyOfTask]?[0].name))")
        print("mainTaskHolder[keyOfTask].numberOfNestedTasks \(String(describing: mainTaskHolder[keyOfTask]?[0].numberOfNestedTasks))")
        print("mainTaskHolder[keyOfTask].nestedTasks.count \(String(describing: mainTaskHolder[keyOfTask]?[0].nestedTasks.count))\n")
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
        nextPresentTasks = taskHolder
        tableView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if keyOfTask != "0" {
            if keyOfTask == "0" {
                backBarButtonItem.tintColor = .white
            }
            mainTaskHolder[keyOfTask] = nextPresentTasks
            print("saved with back")
            print("old keyOfTask \(keyOfTask)")
            print("mainTaskHolder[keyOfTask].name \(String(describing: mainTaskHolder[keyOfTask]?[0].name))")
            print("mainTaskHolder[keyOfTask].numberOfNestedTasks \(String(describing: mainTaskHolder[keyOfTask]?[0].numberOfNestedTasks))")
            print("mainTaskHolder[keyOfTask].nestedTasks.count \(String(describing: mainTaskHolder[keyOfTask]?[0].nestedTasks.count))\n")
            print("Back")

            keyOfTask = String(keyOfTask.dropLast())

//            presentedTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]
            print("keyOfTask \(keyOfTask)")
            print("mainTaskHolder[keyOfTask].name \(String(describing: mainTaskHolder[keyOfTask]?[0].name))")
            print("mainTaskHolder[keyOfTask].numberOfNestedTasks \(String(describing: mainTaskHolder[keyOfTask]?[0].numberOfNestedTasks))")
            print("mainTaskHolder[keyOfTask].nestedTasks.count \(String(describing: mainTaskHolder[keyOfTask]?[0].nestedTasks.count))")
            nextPresentTasks = mainTaskHolder[keyOfTask] ?? [Task(name: "111")]

            tableView.reloadData()
        }
    }
}
