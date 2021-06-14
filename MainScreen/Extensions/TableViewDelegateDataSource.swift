//
//  TableViewDelegateDataSource.swift
//  NewsFeed
//
//  Created by RM on 10.06.2021.
//

import UIKit
import SafariServices

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterArray.count
        }
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseid, for: indexPath) as? TableViewCell else { fatalError() }
        var article: TableViewCellViewModel
        if isFiltering {
            article = filterArray[indexPath.row]
        } else {
            article = viewModels[indexPath.row]
        }
        
        cell.configure(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article: TableViewCellViewModel
        if isFiltering {
            article = filterArray[indexPath.row]
        } else {
            article = viewModels[indexPath.row]
        }
        guard let url = URL(string: article.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
}
