//
//  ViewController.swift
//  NewsFeed
//
//  Created by RM on 09.06.2021.
//

import UIKit

class TableViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseid)
        return table
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var filterArray = [TableViewCellViewModel]()
    var articles = [Article]()
    var viewModels = [TableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        navigationItem.title = "Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchTopStories()
        setupSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = ""
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    TableViewCellViewModel(title: $0.title,
                                           subtitle: $0.description ?? "",
                                           imageURL: URL(string: $0.urlToImage ?? ""),
                                           url: $0.url ?? ""
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

    }

}

extension TableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filterArray = viewModels.filter({ (article: TableViewCellViewModel ) -> Bool in
            return article.title.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()

    }
}
