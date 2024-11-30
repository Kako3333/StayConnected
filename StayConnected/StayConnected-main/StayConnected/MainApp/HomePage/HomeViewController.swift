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

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.onTopicsChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                let isEmpty = self?.viewModel.isEmptyState ?? true
                self?.emptyStateView.isHidden = !isEmpty
                self?.tableView.isHidden = isEmpty
            }
        }
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let selectedTab: HomeTab = sender.selectedSegmentIndex == 0 ? .general : .personal
        viewModel.loadTopics(for: selectedTab)
    }

    @objc private func addQuestionTapped() {
        let addQuestionVC = UIViewController()
        addQuestionVC.view.backgroundColor = .white
        addQuestionVC.title = "Add Question"
        navigationController?.pushViewController(addQuestionVC, animated: true)
    }

    private func setupLeftAlignedTitle(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
