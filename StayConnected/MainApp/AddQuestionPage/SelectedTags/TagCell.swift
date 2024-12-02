//
//  TagCell.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

class TagCell: UITableViewCell {
    
    static let identifier = "TagCell"
    
    var tags: [String] = [] {
        didSet {
            print("dasdsa")
        }
    }
    
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
        tagLabel.textColor = .lightGray
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        return tagLabel
    }()
    
    public var selectedTagsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(tagView)
        tagView.addSubview(tagLabel)
        tagView.addSubview(selectedTagsCollection)
        
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tagView.heightAnchor.constraint(equalToConstant: 47),
            
            tagLabel.centerYAnchor.constraint(equalTo: tagView.centerYAnchor),
            tagLabel.leftAnchor.constraint(equalTo: tagView.leftAnchor),
            
            selectedTagsCollection.topAnchor.constraint(equalTo: tagView.topAnchor),
            selectedTagsCollection.leftAnchor.constraint(equalTo: tagLabel.rightAnchor, constant: 10),
            selectedTagsCollection.rightAnchor.constraint(equalTo: tagView.rightAnchor, constant: -5),
            selectedTagsCollection.bottomAnchor.constraint(equalTo: tagView.bottomAnchor),
            selectedTagsCollection.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    private func configureCollectionView() {
        selectedTagsCollection.delegate = self
        selectedTagsCollection.dataSource = self
        selectedTagsCollection.register(SelectedTagsCell.self, forCellWithReuseIdentifier: SelectedTagsCell.identifier)
    }
    
}

extension TagCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedTagsCell.identifier, for: indexPath) as? SelectedTagsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: tags[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        let size = (tag as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)])
        return CGSize(width: size.width + 20, height: 30)
    }
}
