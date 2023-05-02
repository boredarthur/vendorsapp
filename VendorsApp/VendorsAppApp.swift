//
//  VendorsAppApp.swift
//  VendorsApp
//
//  Created by Артур Заволович on 02.05.2023.
//

import SwiftUI

@main
struct VendorsAppApp: App {
    
    let searchStore = SearchStore(initialState: .init(), reducer: searchReducer)
    
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(searchStore)
        }
    }
}
