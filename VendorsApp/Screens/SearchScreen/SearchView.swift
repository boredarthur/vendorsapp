//
//  SearchView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 02.05.2023.
//

import SwiftUI
import Combine

struct SearchView: View {
    
    // MARK: - Properties (public)
    
    @EnvironmentObject var searchStore: SearchStore
    
    // MARK: - Properties (private)
    
    @StateObject var searchQuery = DebouncedQuery()
    
    // MARK: - View layout
    
    var body: some View {
        VStack {
            SearchBarView(searchQuery: $searchQuery.query)
                .onChange(of: searchQuery.debouncedQuery) { searchQuery in
                    if searchStore.state.isSearching, searchQuery.count < 4 {
                        searchStore.dispatch(.fetch)
                    }
                    
                    guard searchQuery.count > 3 else { return }
                    searchStore.dispatch(.search(searchQuery))
                }
            if searchStore.state.vendors.count == 0 {
                Spacer()
                EmptyResultsView()
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 25.0) {
                        ForEach(searchStore.state.vendors, id: \.id) { vendor in
                            VendorCardView(vendor: vendor)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
        .onAppear {
            searchStore.dispatch(.fetch)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchStore(initialState: .init(vendors: [.init(id: 0,
                                                                               companyName: "Nice Guys",
                                                                               areaServed: "Lviv",
                                                                               shopType: "Cafe",
                                                                               favorited: true,
                                                                               follow: false,
                                                                               businessType: "Cafe",
                                                                               coverPhoto: .init(id: 0,
                                                                                                 mediaUrl: "https://media-cdn.tripadvisor.com/media/photo-s/1c/93/d7/ae/calvin-j-candie.jpg",
                                                                                                 mediaType: .image),
                                                                               categories: [.init(id: 0, name: "Food", image: .init(id: 0,
                                                                                                                                    mediaUrl: "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
                                                                                                                                    mediaType: .image))],
                                                                               tags: [.init(id: 0,
                                                                                            name: "Food",
                                                                                            purpose: "Food")])]),
                                           reducer: searchReducer))
    }
}
