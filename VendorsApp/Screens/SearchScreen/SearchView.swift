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
    
    @State private var searchQuery: String = ""
    
    // MARK: - View layout
    
    var body: some View {
        VStack {
            SearchBarView(searchQuery: $searchQuery)
                .onReceive(Just(searchQuery)) { searchQuery in
                    print(searchQuery)
                }
            ScrollView {
                VStack(spacing: 25.0) {
                    ForEach(searchStore.state.vendors, id: \.id) { vendor in
                        VendorCardView(vendor: vendor)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            searchStore.dispatch(.fetch)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchStore(initialState: .init(), reducer: searchReducer))
    }
}
