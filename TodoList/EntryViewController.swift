//
//  EntryViewController.swift
//  TodoList
//
//  Created by Bekarys Sandigali on 03.03.2024.
//

import UIKit

protocol EntryViewControllerDelegate: AnyObject {
    func didAddTask(_ task: Todo)
}
class EntryViewController: UIViewController,UITextFieldDelegate {
    
    weak var delegate: EntryViewControllerDelegate?
    let smiles = [""]

    lazy var textField:UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your task"
        field.backgroundColor = .gray
        field.borderStyle = .roundedRect
        field.backgroundColor = .white
        field.textColor = .black
        field.layer.borderColor = .init(gray: 255/255, alpha: 1)
        field.delegate = self
        return field
    }()
    lazy var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addTaskTappedEntry), for: .touchUpInside)
        return button
    }()
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        // Do any additional setup after loading the view.
    }
    @objc func addTaskTappedEntry(){
        guard let taskText = textField.text, !taskText.isEmpty else {
                let alert = UIAlertController(title: "Empty Field", message: "Please enter a task.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
                return
            }

            
        let iconNames = ["person.crop.circle.fill", "person.circle.fill", "person.fill"]
        let selectedIcons = iconNames.shuffled().randomElement() ?? "person.fill"
            
        let newTask = Todo(title: taskText, count: 1, smiles: [selectedIcons])
            delegate?.didAddTask(newTask)
            navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func setUp() {
        view.addSubview(textField)
        view.addSubview(addButton)
        
        
        textField.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(200)
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                make.width.equalTo(350)
            }
        addButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
    }
    

}
