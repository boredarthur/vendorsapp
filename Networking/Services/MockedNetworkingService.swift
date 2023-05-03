//
//  MockedNetworkingService.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation
import Combine

class MockedNetworkingService: NetworkingService {

    func fetchData<T: Decodable>(for type: T.Type, from url: URL) -> AnyPublisher<T, Error> {
        return Just(url)
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
