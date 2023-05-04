//
//  VendorCardView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI

struct TempCategory {
    var iconName: String
    var title: String
}

struct VendorCardView: View {
    
    private var tags: [String] = ["Some tag",
                                  "Some tag",
                                  "Some tag",
                                  "Some tag",
                                  "Some tag",
                                  "Some tag"]
    @State private var categories: [TempCategory] = [.init(iconName: "questionmark", title: "Category one"),
                                                     .init(iconName: "questionmark", title: "Category two"),
                                                     .init(iconName: "questionmark", title: "Category three"),
                                                     .init(iconName: "questionmark", title: "Category four"),
                                                     .init(iconName: "questionmark", title: "Category four"),
                                                     .init(iconName: "questionmark", title: "Category four")]
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        FavoritedView()
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Text("Location")
                            .font(.system(size: 16.0, weight: .regular))
                            .foregroundColor(Color("primaryGray"))
                            .padding([.leading, .trailing])
                            .background(
                                RoundedRectangle(cornerRadius: 16.0)
                                    .foregroundColor(.white)
                            )
                            .offset(x: 8.0, y: -8.0)
                        Spacer()
                    }
                }
            }
            .frame(height: 170.0)
            .background(
                Color.red
                    .overlay(
                        LinearGradient(colors: [.clear, Color("customBlack")],
                                       startPoint: .top,
                                       endPoint: .bottom)
                        .cornerRadius(10.0)
                        .opacity(0.8)
                    )
            )
            .cornerRadius(10.0)
            
            VStack(alignment: .leading, spacing: 10.0) {
                HStack {
                    Text("Title")
                        .font(.system(size: 18.0, weight: .bold))
                        .foregroundColor(Color("primaryGray"))
                    Spacer()
                }
                VerticalFlow(items: $categories) { category in
                    HStack(spacing: 5.0) {
                        Image(systemName: category.iconName)
                            .font(.system(size: 16.0, weight: .light))
                        Text(category.title)
                            .foregroundColor(Color("primaryGray"))
                            .font(.system(size: 16.0, weight: .regular))
                    }
                }
                Text(tags.map { "• \($0)" }.joined(separator: " "))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("secondaryGray"))
            }
        }
        .padding(.horizontal)
    }
}

struct VendorCardView_Previews: PreviewProvider {
    static var previews: some View {
        VendorCardView()
    }
}
