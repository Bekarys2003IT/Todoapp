//
//  TaskViewController.swift
//  TodoList
//
//  Created by Bekarys Sandigali on 03.03.2024.
//

import UIKit

protocol TaskViewControllerDelegate: AnyObject {
    func didUpdateTask(_ task: Todo, atIndex index: Int)
    func didDeleteTask(atIndex index: Int)
}

class TaskViewController: UIViewController {
    weak var delegate: TaskViewControllerDelegate?
    var taskTitle:String?
    let smiles = ["person.crop.circle.fill", "person.circle.fill", "person.fill"]
    var todo: Todo?
    var taskIndex:Int?
    
    private lazy var taskField:UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.backgroundColor = .white
        field.textColor = .black
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        field.attributedPlaceholder = NSAttributedString(string: taskTitle ?? "", attributes: placeholderAttributes)
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.black.cgColor
        field.borderStyle = .roundedRect
        field.layer.cornerRadius = 16
        return field
    }()

    private lazy var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return button
    }()
    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action:#selector(deleteTask))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        if let todo = todo {  // Check if there is an existing todo object
            taskField.text = todo.title  // Set the text field to the current task's title
        }
    }
    func setUp(){
        view.addSubview(taskField)
        view.addSubview(addButton)
        navigationItem.rightBarButtonItem = deleteButton
        
        //constraint
        taskField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(taskField.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        
        
    }
    @objc func addTask() {
        guard let taskText = taskField.text, !taskText.isEmpty else {
            let alert = UIAlertController(title: "Empty Field", message: "Please enter a task.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        guard let index = taskIndex else {
                    print("Task index is nil.")  // Handle as appropriate for your app
                    return
                }

                let updatedTask = Todo(title: taskText, count: todo?.count ?? 1, smiles: todo?.smiles ?? smiles)  // Use default smiles if none present
                delegate?.didUpdateTask(updatedTask, atIndex: index)
                navigationController?.popViewController(animated: true)
    }
    @objc func deleteTask(){
        let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
                    self.delegate?.didDeleteTask(atIndex: self.taskIndex ?? 0)
                    self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(UIAlertAction(title: "No", style: .cancel))
                present(alert, animated: true)
            }
}
