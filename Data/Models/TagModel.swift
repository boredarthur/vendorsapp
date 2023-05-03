//
//  TagModel.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation

struct Tag: Codable {
    let id: Int
    let name, purpose: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case purpose
    }
}
