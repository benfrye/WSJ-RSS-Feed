//
//  FeedSelectorViewModel.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/3/20.
//

import Foundation

class FeedSelectorViewModel {
    let feeds: [RSSEndpoint]
    
    private let networkInteractor: NetworkInteractorProtocol?
    
    init(feeds: [RSSEndpoint]? = nil, withNetworkInteractor networkInteractor: NetworkInteractorProtocol?) {
        self.feeds = feeds ?? RSSEndpoint.allCases
        self.networkInteractor = networkInteractor
    }
    
    func makeFeedViewModel(from endpoint: RSSEndpoint) -> FeedViewModel {
        return FeedViewModel(endpoint, withNetworkInteractor: networkInteractor)
    }
}
