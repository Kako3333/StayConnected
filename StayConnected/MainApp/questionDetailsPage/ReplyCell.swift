//
//  ReplyCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    static let identifier = "ReplyCell"
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let replyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userNameLabel)
        contentView.addSubview(replyTextLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            replyTextLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            replyTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            replyTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            replyTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with reply: Reply) {
        userNameLabel.text = reply.userName
        replyTextLabel.text = reply.text
    }
}
