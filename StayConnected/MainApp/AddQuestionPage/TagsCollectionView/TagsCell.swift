//
//  TagsCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

class TagsCell: UITableViewCell {
    
    static let identifier = "TagsCell"
    
    var tags: [String] = ["Swift", "UIKit", "iOS", "SwiftUI", "UI/UX", "FrontEnd", "BackEnd"]
    
    private let tagsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
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
            tagsCollection.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tagsCollection.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tagsCollection.heightAnchor.constraint(equalToConstant: 100)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.row]
        
        let width = tag.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width + 40
        return CGSize(width: width, height: 30) // Adjust the height as needed
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5  // 10px vertical spacing between rows
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
}
