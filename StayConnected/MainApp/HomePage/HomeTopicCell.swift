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
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray
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

    private let answeredCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = UIColor.systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
            repliesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            repliesLabel.trailingAnchor.constraint(equalTo: answeredCheckmark.leadingAnchor, constant: -8),
            repliesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            answeredCheckmark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            answeredCheckmark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            answeredCheckmark.widthAnchor.constraint(equalToConstant: 24),
            answeredCheckmark.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: repliesLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

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
            tagLabel.layer.cornerRadius = 8
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


