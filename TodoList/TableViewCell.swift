//
//  TableViewCell.swift
//  TodoList
//
//  Created by Bekarys Sandigali on 03.03.2024.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    lazy var noticeLabel:UILabel = {
       let label = UILabel()
        label.text = ""
        return label
    }()
    lazy var countLabel:UILabel = {
       let label = UILabel()
        label.text = ""
        return label
    }()
    lazy var iconStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
            stackView.spacing = 8
            return stackView
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    func setUp(){
        contentView.addSubview(noticeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(iconStackView)
        noticeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(50)
            // Example constraints
            }
        countLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
            make.trailing.equalTo(noticeLabel.snp.leading).offset(20)
        }
        iconStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    func configure(with todo:Todo){
       noticeLabel.text = todo.title
        countLabel.text = "\(todo.count)"
        iconStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        iconStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            // Since there's now only one icon, simply add it to the stack view
            if let iconName = todo.smiles.first {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = .systemBlue
                imageView.image = UIImage(systemName: iconName)
                iconStackView.addArrangedSubview(imageView)
            }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension TableViewCell {
    static let availableIcons = ["person.crop.circle.fill", "person.circle.fill", "person.fill"]
}
