//
//  TagsCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

class TagsCell: UITableViewCell {
    
    static let identifier = "TagsCell"
    
    var tags: [String] = ["Swift", "UIKit", "iOS", "SwiftUI", "UI/UX", "FrontEnd", "BackEnd"] {
        didSet {
            selectedTagsCell?.selectedTagsCollection.reloadData()
            tagsCollection.reloadData()
        }
    }
    
    var selectedTagsCell: TagCell?
    
    private let tagsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tagsCollection.register(CollectionTagCell.self, forCellWithReuseIdentifier: CollectionTagCell.identifier)
        tagsCollection.dataSource = self
        tagsCollection.delegate = self
        
        contentView.addSubview(tagsCollection)
        
        NSLayoutConstraint.activate([
            tagsCollection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tagsCollection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            tagsCollection.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagsCollection.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionTagCell.identifier, for: indexPath) as! CollectionTagCell
        cell.configure(with: tags[indexPath.row])
        self.selectionStyle = .none
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.row]
        
        let width = tag.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 40
        return CGSize(width: width, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //removing
        let selectedTag = tags[indexPath.row]
        tags.remove(at: indexPath.row)
        
        //appending
        TagCell.tags.append(selectedTag)
        
        tagsCollection.reloadData()
        selectedTagsCell?.selectedTagsCollection.reloadData()
        selectedTagsCell?.selectedTagsCollection.layoutIfNeeded()
        NotificationCenter.default.post(name: .tagsUpdated, object: nil)
    }

}
