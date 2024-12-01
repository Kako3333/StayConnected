//
//  SubjectCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

class SubjectCell: UITableViewCell {
    
    static let identifier = "SubjectCell"
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .lightGrayText
        textField.borderStyle = .none
        
        let leftLabel = UILabel()
        leftLabel.text = "Subject: "
        leftLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        leftLabel.textColor = .lightGrayText
        leftLabel.sizeToFit()
        textField.leftView = leftLabel
        textField.leftViewMode = .always
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 47),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


