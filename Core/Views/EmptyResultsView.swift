//
//  EmptyResultsView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI

struct EmptyResultsView: View {
    var body: some View {
        VStack(spacing: 8.0) {
            Text("Sorry! No results found...")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreen"))
            Text("Please try a different search request or browse businesses from the list")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("primaryGray"))
        }.padding()
    }
}

struct EmptyResultsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyResultsView()
    }
}
