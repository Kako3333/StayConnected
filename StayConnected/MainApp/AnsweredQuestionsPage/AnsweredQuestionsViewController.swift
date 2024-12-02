//
//  AnsweredQuestionsViewController.swift
//  StayConnected
//
//  Created by Gio Kakaladze on 02.12.24.
//

import UIKit

class AnsweredQuestionsViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel = AnsweredQuestionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadQuestions()
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        title = "Answered Questions"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTopicCell.self, forCellReuseIdentifier: "HomeTopicCell")
        
        searchBar.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.onQuestionsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension AnsweredQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTopicCell", for: indexPath) as? HomeTopicCell else {
            return UITableViewCell()
        }
        let answeredQuestion = viewModel.questions[indexPath.row]
        let topic = Topic(title: answeredQuestion.title, tags: answeredQuestion.tags, replies: answeredQuestion.replies, isAnswered: answeredQuestion.isAnswered, question: answeredQuestion.title)
        
        cell.configure(with: topic)
        return cell    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIViewController()
        detailVC.view.backgroundColor = .white
        detailVC.title = "Question Detail"
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension AnsweredQuestionsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterQuestions(query: searchText)
    }
}
