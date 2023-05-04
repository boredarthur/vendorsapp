//
//  SearchBarView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchQuery: String
    
    var body: some View {
        HStack {
            TextField("", text: $searchQuery)
                .foregroundColor(.black)
                .background(
                    ZStack {
                        Color.white
                        if searchQuery.isEmpty {
                            HStack {
                                Text("Search...")
                                    .font(.system(size: 18.0, weight: .regular))
                                    .foregroundColor(Color("secondaryGray"))
                                Spacer()
                            }
                        }
                    }
                )
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10.0)
                        .foregroundColor(Color("secondaryGray"))
                        .opacity(searchQuery.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchQuery = ""
                        }
                    ,alignment: .trailing
                )
            if searchQuery.isEmpty {
                Image("icon_search")
                    .resizable()
                    .frame(width: 24.0, height: 24.0)
            }
        }
        .font(.system(size: 16.0, weight: .regular))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16.0)
                .fill(Color.white)
                .shadow(
                    color: Color.black.opacity(0.05),
                    radius: 14.0,
                    x: 0.0,
                    y: 16.0
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchQuery: .constant(""))
    }
}
