//
//  NetworkingService.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation
import Combine

protocol NetworkingService {
    func fetchData<T: Decodable>(for type: T.Type, from url: URL) -> AnyPublisher<T, Error>
}
