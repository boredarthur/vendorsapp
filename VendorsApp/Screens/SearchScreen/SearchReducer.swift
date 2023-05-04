//
//  SearchReducer.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation
import Combine

func searchReducer(state: inout SearchState, action: SearchAction) -> AnyPublisher<SearchAction, Never>? {
    
    switch action {
        case .setVendors(let vendors):
            state.vendors = vendors
        case .appendVendors(let vendors):
            state.vendors.append(contentsOf: vendors)
        case .fetch:
            state.isSearching = false
        case .search(_):
            state.isSearching = true
        default:
            break
    }
    return nil
}
