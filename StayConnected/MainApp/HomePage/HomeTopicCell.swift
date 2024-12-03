//
//  HomeTopicCell.swift
//  StayConnected
//
//  Created by Tiko on 29.11.24.
//
import UIKit

class HomeTopicCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let repliesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(hex: "#A1A1A5")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let answeredCheckmark: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(hex: "#ECFDF5")
        containerView.layer.cornerRadius = 13
        containerView.clipsToBounds = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        imageView.tintColor = UIColor.systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        return containerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(repliesLabel)
        contentView.addSubview(tagStackView)
        contentView.addSubview(answeredCheckmark)

        NSLayoutConstraint.activate([
            repliesLabel.trailingAnchor.constraint(equalTo: answeredCheckmark.trailingAnchor),
            repliesLabel.bottomAnchor.constraint(equalTo: answeredCheckmark.topAnchor, constant: -4),
            repliesLabel.widthAnchor.constraint(equalToConstant: 60),
            repliesLabel.heightAnchor.constraint(equalToConstant: 13),
            
            answeredCheckmark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            answeredCheckmark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            answeredCheckmark.widthAnchor.constraint(equalToConstant: 26),
            answeredCheckmark.heightAnchor.constraint(equalToConstant: 26),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: repliesLabel.leadingAnchor, constant: -8),

            tagStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tagStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tagStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func configure(with topic: Topic) {
        titleLabel.text = topic.title
        repliesLabel.text = "Replies: \(topic.replies)"
        answeredCheckmark.isHidden = !topic.isAnswered
        tagStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for tag in topic.tags {
            let tagLabel = UILabel()
            tagLabel.text = tag
            tagLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            tagLabel.textColor = UIColor(hex: "4E53A2")
            tagLabel.backgroundColor = UIColor(hex: "EDEBFF")
            tagLabel.layer.cornerRadius = 14
            tagLabel.clipsToBounds = true
            tagLabel.textAlignment = .center
            tagLabel.setContentHuggingPriority(.required, for: .horizontal)
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            tagLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
            tagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            tagStackView.addArrangedSubview(tagLabel)
        }
    }
}
