//
//  ProfilePageVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 29.11.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pfp")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Shawn Howard"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "shawn_howard@gmail.com"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "INFORMATION"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorColor: UIColor = UIColor.systemGray5
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreValueLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var answeredQuestionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Answered Questions"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .gray
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openAnsweredQuestionsPage))
        label.addGestureRecognizer(tapGesture)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let answeredQuestionsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setImage(UIImage(named: "Logout_icon"), for: .normal)
        button.tintColor = .gray
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(ProfileViewController.self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func logoutTapped() {
        exit(0) // დროებითი logout solution
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileLabel)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(informationLabel)
        view.addSubview(scoreLabel)
        view.addSubview(scoreValueLabel)
        view.addSubview(answeredQuestionsLabel)
        view.addSubview(answeredQuestionsValueLabel)
        view.addSubview(logoutButton)
        
        addSeparator(below: scoreValueLabel)
        addSeparator(below: answeredQuestionsValueLabel)
        addSeparator(below: logoutButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profileImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 16),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            informationLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 64),
            informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            scoreLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 24),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scoreValueLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            scoreValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            answeredQuestionsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 24),
            answeredQuestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            answeredQuestionsValueLabel.centerYAnchor.constraint(equalTo: answeredQuestionsLabel.centerYAnchor),
            answeredQuestionsValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            logoutButton.topAnchor.constraint(equalTo: answeredQuestionsLabel.bottomAnchor, constant: 24),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addSeparator(below view: UIView) {
        let separator = UIView()
        separator.backgroundColor = separatorColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: view.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc private func openAnsweredQuestionsPage() {
        let answeredQuestionsVC = AnsweredQuestionsViewController()
        navigationController?.pushViewController(answeredQuestionsVC, animated: true)
    }
}
