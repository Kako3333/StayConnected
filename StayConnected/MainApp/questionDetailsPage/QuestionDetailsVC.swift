//
//  QuestionDetailsVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import UIKit

struct Reply {
    let profilePic: UIImage
    let userName: String
    let text: String
    let date: String
}


class QuestionDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var topic: Topic?
    private var replies: [Reply] = []
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let questionView: UIView = {
        let questionView = UIView()
        questionView.backgroundColor = .clear
        questionView.translatesAutoresizingMaskIntoConstraints = false
        return questionView
    }()
    
    private let questionTitle: UILabel = {
        let questionTitle = UILabel()
        questionTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        questionTitle.textColor = .lightGray
        questionTitle.translatesAutoresizingMaskIntoConstraints = false
        return questionTitle
    }()
    
    private let questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .left
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        return questionLabel
    }()
    
    private let dateAdded: UILabel = {
        let dateAdded = UILabel()
        dateAdded.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        dateAdded.textColor = .lightGrayText
        dateAdded.translatesAutoresizingMaskIntoConstraints = false
        return dateAdded
    }()
    
    private let replyTableView: UITableView = {
        let replyTableView = UITableView()
        replyTableView.backgroundColor = .orange
        replyTableView.translatesAutoresizingMaskIntoConstraints = false
        return replyTableView
    }()
    
    private let replyTextField: UITextField = {
        let replyTextField = UITextField()
        replyTextField.layer.cornerRadius = 12
        replyTextField.placeholder = "Type Your reply here"
        replyTextField.textColor = .systemGray4
        replyTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        replyTextField.backgroundColor = .white
        
        replyTextField.layer.borderWidth = 1
        replyTextField.layer.borderColor = UIColor.systemGray4.cgColor
        
        replyTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: replyTextField.frame.height))
        replyTextField.leftViewMode = .always
        replyTextField.translatesAutoresizingMaskIntoConstraints = false
        return replyTextField
    }()
    
    private let sendButton: UIButton = {
        let sendButton = UIButton(type: .custom)
        let sendImage = UIImage(named: "sendIcon")?.withRenderingMode(.alwaysTemplate)
        sendButton.setImage(sendImage, for: .normal)
        sendButton.tintColor = .systemGray4
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        return sendButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(questionView)
        questionView.addSubview(questionTitle)
        questionView.addSubview(questionLabel)
        questionView.addSubview(dateAdded)
        view.addSubview(replyTableView)
        view.addSubview(replyTextField)
        replyTextField.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            questionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            
            questionTitle.topAnchor.constraint(equalTo: questionView.topAnchor),
            questionTitle.leftAnchor.constraint(equalTo: questionView.leftAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: questionTitle.bottomAnchor, constant: 8),
            questionLabel.leftAnchor.constraint(equalTo: questionView.leftAnchor),
            questionLabel.rightAnchor.constraint(equalTo: questionView.rightAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: questionView.bottomAnchor),
            
            dateAdded.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 5),
            dateAdded.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            dateAdded.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            dateAdded.heightAnchor.constraint(equalToConstant: 20),
            
            replyTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 9),
            replyTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -9),
            replyTableView.topAnchor.constraint(equalTo: dateAdded.bottomAnchor, constant: 15),
            replyTableView.bottomAnchor.constraint(equalTo: replyTextField.topAnchor, constant: -30),
            
            replyTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            replyTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            replyTextField.heightAnchor.constraint(equalToConstant: 43),
            
            sendButton.centerYAnchor.constraint(equalTo: replyTextField.centerYAnchor),
            sendButton.rightAnchor.constraint(equalTo: replyTextField.rightAnchor, constant: -10),
        ])
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendButtonPressed() {
        guard
            let replyText = replyTextField.text, !replyText.isEmpty
        else { return }
        
//        let newReply = Reply(profilePic: UIImage(named: "profileIcon"), userName: "", text: <#T##String#>, date: <#T##String#>)
        
        print("pressed")
    }
    
    func configure(with topic: Topic) {
        self.topic = topic
        questionTitle.text = topic.title
        questionLabel.text = topic.question
        
        //Droebit
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH"
        let formattedDate = formatter.string(from: Date())
        dateAdded.text = "@userNameHere asked on \(formattedDate):00"
    }
    
    private func setupTableView() {
        replyTableView.dataSource = self
        replyTableView.delegate = self
        
        replyTableView.register(ReplyCell.self, forCellReuseIdentifier: ReplyCell.identifier)
        
        replyTableView.rowHeight = UITableView.automaticDimension
        replyTableView.estimatedRowHeight = 100
    }
    
    //TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReplyCell.identifier, for: indexPath)
        
        let reply = replies[indexPath.row]
        cell.textLabel?.text = "\(reply.userName): \(reply.text)"
        
        return cell
    }
}

