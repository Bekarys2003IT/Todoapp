//
//  ViewController.swift
//  TodoList
//
//  Created by Bekarys Sandigali on 03.03.2024.
//

import UIKit



class ViewController: UIViewController {
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "ToDo Items"
        return label
    }()
    lazy var logoImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "log")
        image.layer.cornerRadius = 16
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .white
        
        setUI()
    }
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(logoImage)
        
        //constraint
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            navigateToTableViewController()
        }
        func navigateToTableViewController(){
            let tableVC = TableViewController()  // Directly instantiate TableViewController
            self.navigationController?.pushViewController(tableVC, animated: true)
            }
            
            
        }
        
        
        
    }
    

