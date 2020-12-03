//
//  ItemCell.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/3/20.
//

import SwiftUI

struct ItemCell: View {
    @ObservedObject var item: Item
    @ObservedObject var viewModel: FeedViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 5) {
            Button(action: {
                viewModel.safariViewShowing = true
            }) {
                Text(item.title ?? "")
            }
            .padding(.top, 5)
            .sheet(isPresented: $viewModel.safariViewShowing,
                   content: {
                    if let link = item.link, let url = URL(string: link) {
                        SafariView(url: url)
                    }
                   })
            
            if let date = item.pubDate {
                Text("\(date, formatter: viewModel.dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            if let description = item.description {
                Text(description)
                    .font(.caption)
                    .padding(.bottom, 5)
            }
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item(title: "Title",
                        link: "link",
                        description: "description",
                        pubDate: Date())
        ItemCell(item: item, viewModel: FeedViewModel(items: [item], .USBusiness, withNetworkInteractor: nil))
    }
}
