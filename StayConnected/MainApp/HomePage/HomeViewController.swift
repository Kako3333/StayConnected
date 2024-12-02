//
//  HomeViewController.swift
//  StayConnected
//
//  Created by Tiko on 29.11.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["General", "Personal"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = UIColor.systemGray6
        control.selectedSegmentTintColor = UIColor(hex: "4E53A2")
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor(hex: "777E99")], for: .normal)
        control.layer.cornerRadius = 12
        control.layer.masksToBounds = true
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let tagsView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let tags = ["Frontend", "iOS", "SwiftUI", "Backend", "UIKit"]
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        tags.forEach { tag in
            let label = UILabel()
            label.text = tag
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textColor = UIColor(hex: "4E53A2")
            label.textAlignment = .center
            label.backgroundColor = UIColor(hex: "EDEBFF")
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 28).isActive = true
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
            stackView.addArrangedSubview(label)
        }
        
        container.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        return container
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = UIColor(hex: "4E53A2")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let emptyStateView = EmptyStateView()
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadTopics(for: .general)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = nil
        navigationController?.navigationBar.topItem?.title = nil
        setupLeftAlignedTitle("Questions")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addQuestionTapped)
        )
        
        view.addSubview(segmentedControl)
        view.addSubview(searchBar)
        view.addSubview(tagsView)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTopicCell.self, forCellReuseIdentifier: "HomeTopicCell")
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        searchBar.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 39),
            
            searchBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tagsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tagsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tagsView.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
            viewModel.onTopicsChanged = { [weak self] in
                DispatchQueue.main.async {
                    let isEmpty = self?.viewModel.isEmptyState ?? true
                    self?.emptyStateView.isHidden = !isEmpty
                    self?.tableView.isHidden = isEmpty
                    
                    if isEmpty {
                        self?.emptyStateView.configure(
                            image: UIImage(named: "EmptyPersonal")!,
                            title: "Got a question in mind?",
                            message: "Ask it and wait for like-minded people to answer"
                        )
                    }
                    self?.tableView.reloadData()
                }
            }
        }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let selectedTab: HomeTab = sender.selectedSegmentIndex == 0 ? .general : .personal
        viewModel.loadTopics(for: selectedTab)
    }
    
    @objc private func addQuestionTapped() {
        let addQuestionVC = AddQuestionVC()
        navigationController?.present(addQuestionVC, animated: true)
        addQuestionVC.delegate = self
    }
    
    private func setupLeftAlignedTitle(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.titleView = UIView()
        navigationItem.titleView?.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: navigationItem.titleView!.leadingAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: navigationItem.titleView!.centerYAnchor)
        ])
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTopicCell", for: indexPath) as? HomeTopicCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.topics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionDetailsPage = QuestionDetailsVC()
        let selectedQuestion = viewModel.topics[indexPath.row]
        questionDetailsPage.configure(with: selectedQuestion)
        navigationController?.pushViewController(questionDetailsPage, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTopics(query: searchText)
    }
}

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension HomeViewController: AddQuestionDelegate {
    func didAddQuestion(_ topic: Topic) {
        viewModel.topics.append(topic)
        viewModel.onTopicsChanged?()
    }
}

