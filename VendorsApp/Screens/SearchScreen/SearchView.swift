//
//  SearchView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 02.05.2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var searchStore: SearchStore
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(String(searchStore.state.vendors.count))
        }
        .padding()
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
