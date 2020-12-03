//
//  FeedView.swift
//  WSJ RSS Reader
//
//  Created by Ben Frye on 12/2/20.
//

import SwiftUI
import Combine

struct FeedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: FeedViewModel
    
    var body: some View {
        List(viewModel.items) { ItemCell(item: $0, viewModel: viewModel) }
            .navigationBarTitle(Text(viewModel.title))
            .onAppear(perform: { viewModel.viewDidAppear = true })
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text(LocalizedStrings.FetchError.localized),
                      message: nil,
                      dismissButton: Alert.Button.default(
                        Text(LocalizedStrings.Dismiss.localized), action: {
                            viewModel.error = nil
                            presentationMode.wrappedValue.dismiss()
                        }
                      ))
            }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Item(title: "Title",
                        link: "link",
                        description: "description",
                        pubDate: Date())
        NavigationView(content: {
            FeedView(viewModel: FeedViewModel(items: [item, item, item, item],
                                              .USBusiness,
                                              withNetworkInteractor: nil))
        })
    }
}
