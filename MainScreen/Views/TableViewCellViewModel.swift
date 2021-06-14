//
//  TableViewCellViewModel.swift
//  NewsFeed
//
//  Created by RM on 10.06.2021.
//

import UIKit

class TableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    let url: String?
    
    init (
        title: String,
        subtitle: String,
        imageURL: URL?,
        url: String?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.url = url
    }
}
