//
//  FavoritedView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI

struct FavoritedView: View {
    
    // MARK: - Properties (public)
    
    @State var isFavorite: Bool
    
    // MARK: - Properties (private)
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isFavorite ? Color("green") : .white)
            Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                .font(.headline.weight(.bold))
                .foregroundColor(isFavorite ? .white : Color("green"))
        }
        .frame(width: 36.0, height: 36.0)
        .offset(x: -10.0, y: 10.0)
        .scaleEffect(isFavorite ? 1.1 : 1.0)
        .gesture(
            DragGesture(minimumDistance: 0.0)
                .onChanged({ _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPressed = true
                        isFavorite.toggle()
                    }
                })
                .onEnded({ _ in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPressed = false
                    }
                })
        )
    }
}

struct FavoritedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoritedView(isFavorite: true)
                .fixedSize()
            
            FavoritedView(isFavorite: false)
                .fixedSize()
        }
    }
}
