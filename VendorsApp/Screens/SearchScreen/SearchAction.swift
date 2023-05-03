//
//  SearchAction.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation

enum SearchAction: BaseAction {
    case fetch
    case setVendors(_ vendors: [Vendor])
}
