//
//  FeedViewModel.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/3/20.
//

import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published private(set) var items: [Item]
    @Published var safariViewShowing = false
    @Published var error: Error? {
        didSet {
            if viewDidAppear {
                showError = error != nil
            }
        }
    }
    var showError: Bool = false
    var viewDidAppear: Bool = false {
        didSet {
            // If the error happens quicker than the view can get on screen, the alert will never show
            // so we wait for onAppear before setting if an error arrives quickly
            showError = error != nil
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var title: String { endpoint.title }
    
    private let networkInteractor: NetworkInteractorProtocol?
    private let endpoint: RSSEndpoint
    private var cancellationToken: AnyCancellable?
    
    init(items: [Item] = [],
         _ endpoint: RSSEndpoint,
         withNetworkInteractor networkInteractor: NetworkInteractorProtocol?) {
        self.items = items
        self.endpoint = endpoint
        self.networkInteractor = networkInteractor
        reloadData()
    }
    
    // Separated to allow for PTR in the future
    func reloadData() {
        cancellationToken = networkInteractor?.fetchRSSFeed(from: endpoint)
            .receive(on: RunLoop.main)
            .mapError({ (error) -> Error in
                self.error = error
                return error
            })
            .sink(receiveCompletion: {_ in },
                  receiveValue: { (feed) in
                    self.items = feed.items
                  })
    }
    
    deinit {
        cancellationToken?.cancel()
    }
}
