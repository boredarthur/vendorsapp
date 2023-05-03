//
//  CategoryModel.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let image: CoverPhoto
}
