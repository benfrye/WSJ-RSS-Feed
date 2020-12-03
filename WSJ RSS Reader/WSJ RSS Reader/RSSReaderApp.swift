//
//  RSSReaderApp.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import SwiftUI

@main
struct RSSReaderApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                FeedSelectorView(viewModel: FeedSelectorViewModel(withNetworkInteractor: NetworkInteractor()))
            })
        }
    }
}
