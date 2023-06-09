//
//  SearchState.swift
//  VendorsApp
//
//  Created by Артур Заволович on 03.05.2023.
//

import Foundation

struct SearchState: BaseState {
    var vendors: [Vendor] = []
    var isSearching: Bool = false
}
