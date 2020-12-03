//
//  Feed.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import Foundation

struct Feed {
    var items: [Item] = []
}

class Item: Identifiable, ObservableObject {
    var id = UUID()
    var title: String?
    var link: String?
    var description: String?
    var pubDate: Date?
    
    init(title: String? = nil, link: String? = nil, description: String? = nil, pubDate: Date? = nil) {
        self.title = title
        self.link = link
        self.description = description
        self.pubDate = pubDate
    }
}
