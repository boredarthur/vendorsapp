//
//  VendorCardView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI
import Kingfisher

struct VendorCardView: View {

    // MARK: - Properties (public)
    
    @State var vendor: Vendor
    
    // MARK: - Initialization

    init(vendor: Vendor) {
        self.vendor = vendor
    }
    
    // MARK: - View layout
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        FavoritedView(isFavorite: vendor.favorited)
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Text(vendor.areaServed)
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
                KFImage.url(URL(string: vendor.coverPhoto.mediaUrl))
                    .cacheMemoryOnly()
                    .loadDiskFileSynchronously()
                    .fade(duration: 0.25)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 170.0)
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
                    Text(vendor.companyName)
                        .font(.system(size: 18.0, weight: .bold))
                        .foregroundColor(Color("primaryGray"))
                    Spacer()
                }
                VerticalFlow(items: $vendor.categories) { category in
                    HStack(spacing: 5.0) {
                        KFImage.url(URL(string: category.image.mediaUrl))
                            .setProcessor(SVGImageProcessor())
                            .cacheMemoryOnly()
                            .loadDiskFileSynchronously()
                            .fade(duration: 0.25)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22.0, height: 22.0)
                        Text(category.name)
                            .foregroundColor(Color("primaryGray"))
                            .font(.system(size: 16.0, weight: .regular))
                    }
                }
                Text(vendor.tags.map { "• \($0.name)" }.joined(separator: " "))
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color("secondaryGray"))
            }
        }
    }
}

struct VendorCardView_Previews: PreviewProvider {
    static var previews: some View {
        VendorCardView(vendor: Vendor(id: 0,
                                      companyName: "Company",
                                      areaServed: "Lviv",
                                      shopType: "Shop",
                                      favorited: false,
                                      follow: false,
                                      businessType: "Shop",
                                      coverPhoto: .init(id: 0,
                                                        mediaUrl: "url",
                                                        mediaType: .image),
                                      categories: [.init(id: 0,
                                                         name: "Category 1",
                                                         image: .init(id: 0,
                                                                      mediaUrl: "url",
                                                                      mediaType: .image))],
                                      tags: [.init(id: 0,
                                                   name: "Tag",
                                                   purpose: "None")]))
    }
}
