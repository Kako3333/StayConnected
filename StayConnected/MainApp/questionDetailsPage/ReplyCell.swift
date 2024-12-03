//
//  ReplyCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import UIKit

class ReplyCell: UITableViewCell {
    
    static let identifier = "ReplyCell"
    
    let replyView: UIView = {
        let replyView = UIView()
        replyView.backgroundColor = .clear
        replyView.translatesAutoresizingMaskIntoConstraints = false
        return replyView
    }()
    
    let userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return userNameLabel
    }()
    
    let replyTextLabel: UILabel = {
        let replyTextLabel = UILabel()
        replyTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        replyTextLabel.textColor = .lightGrayText
        replyTextLabel.numberOfLines = 0
        replyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return replyTextLabel
    }()
    
    let dateReplied: UILabel = {
        let dateReplied = UILabel()
        dateReplied.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        dateReplied.textColor = .lightGrayText
        dateReplied.translatesAutoresizingMaskIntoConstraints = false
        return dateReplied
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17.5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(replyView)
        replyView.addSubview(profileImageView)
        replyView.addSubview(userNameLabel)
        replyView.addSubview(replyTextLabel)
        replyView.addSubview(dateReplied)
        replyView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            replyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            replyView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            replyView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            replyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: replyView.topAnchor, constant: 3),
            profileImageView.leftAnchor.constraint(equalTo: replyView.leftAnchor, constant: 3),
            profileImageView.widthAnchor.constraint(equalToConstant: 35),
            profileImageView.heightAnchor.constraint(equalToConstant: 35),
            
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -8),
            userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 3),
            
            dateReplied.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 8),
            dateReplied.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 3),
            
            replyTextLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            replyTextLabel.leftAnchor.constraint(equalTo: replyView.leftAnchor),
            replyTextLabel.rightAnchor.constraint(equalTo: replyView.rightAnchor),
            replyTextLabel.bottomAnchor.constraint(equalTo: replyView.bottomAnchor, constant: -8),
            
            statusLabel.topAnchor.constraint(equalTo: replyView.topAnchor, constant: 5),
            statusLabel.rightAnchor.constraint(equalTo: replyView.rightAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with reply: Reply) {
        profileImageView.image = reply.profilePic
        userNameLabel.text = reply.userName
        replyTextLabel.text = reply.text
        dateReplied.text = reply.date
        statusLabel.text = reply.status
        statusLabel.textColor = reply.status == "Accepted" ? .backgroundColor : .white
    }
}
