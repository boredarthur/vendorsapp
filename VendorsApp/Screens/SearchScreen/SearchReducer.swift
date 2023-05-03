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
        case .fetch:
            let networkService = MockedNetworkingService()
            let url = Bundle.main.url(forResource: "vendors", withExtension: "json")
            
            return networkService.fetchData(for: VendorsResponse.self, from: url!)
                .replaceError(with: .init(vendors: []))
                .map { SearchAction.setVendors($0.vendors) }
                .eraseToAnyPublisher()
        case .setVendors(let vendors):
            state.vendors = vendors
    }
    return nil
}
