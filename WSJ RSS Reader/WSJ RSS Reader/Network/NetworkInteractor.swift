//
//  NetworkInteractor.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import Foundation
import Combine

protocol NetworkInteractorProtocol: class {
    func fetchRSSFeed(from endpoint: RSSEndpoint) -> AnyPublisher<Feed, Error>
}

final class NetworkInteractor: NetworkInteractorProtocol {
    func fetchRSSFeed(from endpoint: RSSEndpoint) -> AnyPublisher<Feed, Error> {
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: endpoint.url))
            .map(\.data)
            .tryMap { try FeedParser().parse($0) }
            .eraseToAnyPublisher()
    }
}
