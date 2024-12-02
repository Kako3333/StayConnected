//
//  selectedTagsCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 01.12.24.
//

import UIKit

class SelectedTagsCell: UICollectionViewCell {
    
    static let identifier = "SelectedTagsCell"
    
    private let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.tagTextColor, for: .normal)
        button.backgroundColor = UIColor.tagBackgroundColor
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            button.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        button.setTitle(text, for: .normal)
    }
}
