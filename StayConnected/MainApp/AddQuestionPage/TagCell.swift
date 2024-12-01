//
//  TagCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

class TagCell: UITableViewCell {
    
    static let identifier = "TagCell"
    
    private let tagView: UIView = {
        let tagView = UIView()
        tagView.backgroundColor = .clear
        tagView.translatesAutoresizingMaskIntoConstraints = false
        return tagView
    }()
    
    private let tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.text = "Tag:"
        tagLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tagLabel.textColor = .lightGrayText
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        return tagLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagView.heightAnchor.constraint(equalToConstant: 47),
            
            tagLabel.centerYAnchor.constraint(equalTo: tagView.centerYAnchor),
            tagLabel.leftAnchor.constraint(equalTo: tagView.leftAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
