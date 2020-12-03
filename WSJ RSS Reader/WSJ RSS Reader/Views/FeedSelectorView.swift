//
//  FeedSelectorView.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/3/20.
//

import SwiftUI
import Combine

struct FeedSelectorView: View {
    let viewModel: FeedSelectorViewModel
    
    var body: some View {
        List(viewModel.feeds) { feed in
            NavigationLink(
                destination: FeedView(viewModel: viewModel.makeFeedViewModel(from: feed)),
                label: {
                    Text(feed.title)
                })
        }.navigationBarTitle(Text(LocalizedStrings.WallStreetJournal.localized))
    }
}

struct FeedSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(content: {
            FeedSelectorView(viewModel: FeedSelectorViewModel(withNetworkInteractor: nil))
        })
    }
}
