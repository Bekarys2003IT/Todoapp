//
//  TableViewController.swift
//  TodoList
//
//  Created by Bekarys Sandigali on 03.03.2024.
//

import UIKit


class TableViewController: UITableViewController {
    
    var todos = [Todo]()
    var taskCount = 0
    
    
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addTaskTapped), for: .touchUpInside)
        button.tintColor = .blue
        return button
    }()
    
    lazy var sometableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        //        tableView.register(TableViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskTapped))
        
        view.backgroundColor = .white
        setUp()
    }
    private func setUp(){
        tableView.tableFooterView = UIView()
        view.addSubview(sometableView)
        navigationItem.hidesBackButton = true
        
        //constraint
        sometableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    @objc func addTaskTapped(){
        let entryVC = EntryViewController()
        entryVC.delegate = self  // This is crucial
        navigationController?.pushViewController(entryVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("Failed to dequeue TableViewCell.")
        }
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        
        // Make sure this method sets the text properly
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = todos[indexPath.row]
                let taskVC = TaskViewController()
                taskVC.todo = task
                taskVC.taskIndex = indexPath.row
                taskVC.delegate = self
                navigationController?.pushViewController(taskVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
    
    
extension TableViewController: EntryViewControllerDelegate {
    func didAddTask(_ task: Todo) {
            if let index = todos.firstIndex(where: { $0.title == task.title }) {
                // Update existing task
                todos[index].count += 1
                // Optionally, update the specific cell for an immediate UI update
                let indexPath = IndexPath(row: index, section: 0)  // Assuming you have only one section
                tableView.reloadRows(at: [indexPath], with: .automatic)
                
            } else {
                // Add new task and increment taskCount
                taskCount += 1
                let newTask = Todo(title: task.title, count: taskCount, smiles: task.smiles)
                todos.append(newTask)
                tableView.reloadData()  // Refresh the table view to show the new task
            }
        }
    func didAddNewTask(_ task: Todo) {
        todos.append(task)
        tableView.reloadData()
    }
    
}
extension TableViewController: TaskViewControllerDelegate {
    func didUpdateTask(_ updatedTask: Todo, atIndex index: Int) {
        todos[index] = updatedTask
               tableView.reloadData()
        }   
    func didDeleteTask(atIndex index: Int) {
            todos.remove(at: index)
            tableView.reloadData()
        }
    
    

}

    

