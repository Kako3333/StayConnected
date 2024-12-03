//
//  QuestionDetailsVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import UIKit

struct Reply: Codable {
    var profilePicData: Data
    let userName: String
    let text: String
    let date: String
    var status: String
    
    var profilePic: UIImage? {
        return UIImage(data: profilePicData)
    }
    
    enum CodingKeys: String, CodingKey {
        case profilePicData = "profilePic"
        case userName
        case text
        case date
        case status
    }
}

class QuestionDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var topic: Topic?
    private var replies: [Reply] = [] {
        didSet {
            replyTableView.reloadData()
        }
    }
    
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
        view.backgroundColor = .white
        setupUI()
        setupTableView()
        setupDismissKeyboardGesture()
        loadReplies()
        //dasavebuli replys washla gasatestad
//        UserDefaults.standard.removeObject(forKey: "savedReplies")
//        UserDefaults.standard.synchronize()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        view.addSubview(questionView)
        questionView.addSubview(questionTitle)
        questionView.addSubview(questionLabel)
        questionView.addSubview(dateAdded)
        view.addSubview(replyTableView)
        view.addSubview(replyTextField)
        replyTextField.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
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
            replyTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            
            sendButton.centerYAnchor.constraint(equalTo: replyTextField.centerYAnchor),
            sendButton.rightAnchor.constraint(equalTo: replyTextField.rightAnchor, constant: -10),
        ])
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sendButtonPressed() {
        guard let replyText = replyTextField.text, !replyText.isEmpty else { return }
        
        let newReply = Reply(
            profilePicData: UIImage(named: "pfp")!.pngData()!,
            userName: "ShawnHoward",
            text: replyText,
            date: "Monday, 9 May 2024",
            status: ""
        )
        
        replies.append(newReply)
        saveReplies()
        
        DispatchQueue.main.async {
            self.replyTableView.reloadData()
            self.replyTextField.text = nil
        }
    }
    
    func saveReplies() {
        guard let topicId = topic?.id else { return }
        
        let encoder = JSONEncoder()
        do {
            var repliesToSave = replies
            for index in repliesToSave.indices {
                if let image = repliesToSave[index].profilePic {
                    repliesToSave[index].profilePicData = image.pngData() ?? Data()
                }
            }
            
            let data = try encoder.encode(repliesToSave)
            
            var savedReplies = UserDefaults.standard.dictionary(forKey: "savedReplies") as? [String: Data] ?? [:]
            savedReplies[topicId] = data
            UserDefaults.standard.set(savedReplies, forKey: "savedReplies")
        } catch {
            print("Error saving replies: \(error)")
        }
    }

    
    
    func loadReplies() {
        guard let topicId = topic?.id else { return }
        
        if let savedRepliesData = UserDefaults.standard.dictionary(forKey: "savedReplies") as? [String: Data],
           let topicRepliesData = savedRepliesData[topicId] {
            let decoder = JSONDecoder()
            do {
                let decodedReplies = try decoder.decode([Reply].self, from: topicRepliesData)
                replies = decodedReplies
            } catch {
                print("Error loading replies: \(error)")
            }
        }
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
        replyTableView.backgroundColor = .clear
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReplyCell.identifier, for: indexPath) as? ReplyCell else {
            fatalError(":(")
        }
        
        let reply = replies[indexPath.row]
        cell.configure(with: reply)
        
        if reply.status == "Accepted" {
            cell.statusLabel.text = "Accepted"
            cell.statusLabel.textColor = .backgroundColor
        } else if reply.status == "Rejected" {
            cell.statusLabel.text = "Rejected"
            cell.statusLabel.textColor = .systemRed
        } else {
            cell.statusLabel.text = ""
        }
        
        
        return cell
    }
    
    //swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reply = replies[indexPath.row]
        
        let swipeAction: UIContextualAction
        if reply.status == "Accepted" {
            swipeAction = UIContextualAction(style: .normal, title: "Reject") { [weak self] (_, _, completionHandler) in
                
                self?.replies[indexPath.row].status = "Rejected"
                
                if let cell = tableView.cellForRow(at: indexPath) as? ReplyCell {
                    cell.statusLabel.text = "Rejected"
                    cell.statusLabel.textColor = .systemRed
                }
                completionHandler(true)
            }
            swipeAction.backgroundColor = .systemRed
        } else {
            swipeAction = UIContextualAction(style: .normal, title: "Accept") { [weak self] (_, _, completionHandler) in
                
                self?.replies[indexPath.row].status = "Accepted"
                
                if let cell = tableView.cellForRow(at: indexPath) as? ReplyCell {
                    cell.statusLabel.text = "Accepted"
                    cell.statusLabel.textColor = .backgroundColor
                }
                completionHandler(true)
            }
            swipeAction.backgroundColor = .backgroundColor
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [swipeAction])
        swipeConfig.performsFirstActionWithFullSwipe = false
        return swipeConfig
    }
}


