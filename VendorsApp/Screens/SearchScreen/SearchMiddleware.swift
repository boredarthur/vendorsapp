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
                    .map { vendorResponse in
                        let firstVendors = Array(vendorResponse.vendors.prefix(4))
                        let sortedVendors = firstVendors.sorted { $0.companyName > $1.companyName }
                        return SearchAction.setVendors(sortedVendors)
                    }
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
            case .loadMoreVendors(let currentVendor):
                guard currentVendor == state.vendors.last else { break }
                return service.fetchData(for: VendorsResponse.self, from: url!)
                    .subscribe(on: DispatchQueue.main)
                    .replaceError(with: .init(vendors: []))
                    .map { vendorResponse in
                        let filteredVendors = Array(vendorResponse.vendors.filter { $0.id > currentVendor.id }.prefix(4))
                        let sortedVendors = filteredVendors.sorted { $0.companyName > $1.companyName }
                        return SearchAction.appendVendors(sortedVendors)
                    }
                    .eraseToAnyPublisher()
            default:
                break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
