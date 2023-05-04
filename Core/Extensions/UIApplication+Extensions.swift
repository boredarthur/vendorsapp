//
//  UIApplication+Extensions.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
