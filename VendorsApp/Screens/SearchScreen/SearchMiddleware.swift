//
//  SearchMiddleware.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import Foundation
import Combine

func networkingMiddleware(service: NetworkingService) -> Middleware<SearchState, SearchAction> {
    let url = Bundle.main.url(forResource: "vendors", withExtension: "json")
    return { state, action in
        switch action {
            case .fetch:
                return service.fetchData(for: VendorsResponse.self, from: url!)
                    .subscribe(on: DispatchQueue.main)
                    .replaceError(with: .init(vendors: []))
                    .map { SearchAction.setVendors($0.vendors) }
                    .eraseToAnyPublisher()
            case .search(let query):
                return service.fetchData(for: VendorsResponse.self, from: url!)
                    .subscribe(on: DispatchQueue.main)
                    .replaceError(with: .init(vendors: []))
                    .map { vendorResponse in
                        vendorResponse.vendors.filter { vendor in
                            vendor.companyName.contains(query)
                        }
                    }
                    .map { vendors in
                        SearchAction.setVendors(vendors)
                    }
                    .eraseToAnyPublisher()
            default:
                break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}