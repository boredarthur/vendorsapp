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
            var subscriptions = Set<AnyCancellable>()
            
            networkService.fetchData(for: VendorsResponse.self, from: url!)
                .sink { completion in
                    switch completion {
                        case let .failure(error):
                            print("Request finished with error: \(error)")
                        default:
                            break
                    }
                } receiveValue: { vendorResponse in
                    dump(vendorResponse)
                }
                .store(in: &subscriptions)
    }
    return nil
}
