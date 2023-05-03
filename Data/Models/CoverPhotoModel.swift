//
//  CoverPhotoModel.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation

enum MediaType: String, Codable {
    case image = "image"
}

struct CoverPhoto: Codable {
    let id: Int
    let mediaUrl: String
    let mediaType: MediaType
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaUrl = "media_url"
        case mediaType = "media_type"
    }
}
