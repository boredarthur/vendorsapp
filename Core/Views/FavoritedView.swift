//
//  FavoritedView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI

struct FavoritedView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
            Image(systemName: "bookmark")
                .font(.headline.weight(.bold))
                .foregroundColor(Color("green"))
        }
        .frame(width: 36.0, height: 36.0)
        .offset(x: -10.0, y: 10.0)
    }
}

struct FavoritedView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritedView()
    }
}
