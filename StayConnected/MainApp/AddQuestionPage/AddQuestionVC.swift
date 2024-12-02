//
//  AddQuestionVC.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 30.11.24.
//

import UIKit

protocol AddQuestionDelegate: AnyObject {
    func didAddQuestion(_ topic: Topic)
}

class AddQuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: AddQuestionDelegate?
    private var subjectCell: SubjectCell?
    private var homeViewModel: HomeViewModel?

    private let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .offWhite
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.text = "Add Question"
        headerTitle.textColor = .black
        headerTitle.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    private let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.backgroundColor, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    private let questionTextField: UITextField = {
        let questionTextField = UITextField()
        questionTextField.layer.cornerRadius = 12
        questionTextField.placeholder = "Type Your question here"
        questionTextField.textColor = .systemGray4
        questionTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        questionTextField.backgroundColor = .white
        
        questionTextField.layer.borderWidth = 1
        questionTextField.layer.borderColor = UIColor.systemGray4.cgColor
        
        questionTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: questionTextField.frame.height))
        questionTextField.leftViewMode = .always
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        return questionTextField
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
        view.backgroundColor = .white
        setupUI()
        setupTableView()
        questionTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        subjectCell?.textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        headerView.addSubview(headerTitle)
        headerView.addSubview(cancelButton)
        view.addSubview(tableView)
        view.addSubview(questionTextField)
        questionTextField.addSubview(sendButton)
        
        cancelButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 77),
            
            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 23),
            headerTitle.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerTitle.heightAnchor.constraint(equalToConstant: 20),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerTitle.centerYAnchor),
            cancelButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 53),
            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            
            questionTextField.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            questionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            questionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            questionTextField.heightAnchor.constraint(equalToConstant: 43),
            
            sendButton.centerYAnchor.constraint(equalTo: questionTextField.centerYAnchor),
            sendButton.rightAnchor.constraint(equalTo: questionTextField.rightAnchor, constant: -10)
        ])
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubjectCell.self, forCellReuseIdentifier: SubjectCell.identifier)
        tableView.register(TagCell.self, forCellReuseIdentifier: TagCell.identifier)
        tableView.register(TagsCell.self, forCellReuseIdentifier: TagsCell.identifier)
    }
    
    private func updateSendButtonState() {
        if let subjectText = subjectCell?.textField.text, !subjectText.isEmpty,
           let questionText = questionTextField.text, !questionText.isEmpty{
            sendButton.tintColor = .black
        } else {
            sendButton.tintColor = .systemGray4
        }
    }
    
    @objc private func sendButtonPressed() {
        guard
            let subjectText = subjectCell?.textField.text, !subjectText.isEmpty,
            let questionText = questionTextField.text, !questionText.isEmpty
        else { return }

        let newTopic = Topic(
            title: subjectText,
            tags: [subjectText],
            replies: 0,
            isAnswered: false,
            question: questionText
        )
        delegate?.didAddQuestion(newTopic)
        dismiss(animated: true, completion: nil)
        print("pressed")
    }

    
    @objc private func textFieldsDidChange() {
        updateSendButtonState()
    }
    
    // MARK: - TableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubjectCell.identifier, for: indexPath) as! SubjectCell
            subjectCell = cell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.identifier, for: indexPath) as! TagCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = true
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagsCell.identifier, for: indexPath) as! TagsCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
