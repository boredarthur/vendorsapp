//
//  VerticalFlowView.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import Foundation
import SwiftUI

struct VerticalFlow<Item, ItemView: View>: View {
    
    @Binding var items: [Item]
    @ViewBuilder var itemViewBuilder: (Item) -> ItemView
    @State private var size: CGSize = .zero
    
    var hSpacing: CGFloat = 20
    var vSpacing: CGFloat = 10
    
    var body: some View {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        VStack {
            GeometryReader { geometryProxy in
                ZStack(alignment: .topLeading) {
                    ForEach(items.indices, id: \.self) { i in
                        itemViewBuilder(items[i])
                            .alignmentGuide(.leading) { dimensions in
                                if abs(width - dimensions.width) > geometryProxy.size.width {
                                    width = 0
                                    height -= dimensions.height + vSpacing
                                }
                                let leadingOffset = width
                                if i == items.count - 1 {
                                    width = 0
                                } else {
                                    width -= dimensions.width + hSpacing
                                }
                                return leadingOffset
                            }
                            .alignmentGuide(.top) { dimensions in
                                let topOffset = height
                                if i == items.count - 1 {
                                    height = 0
                                }
                                return topOffset
                            }
                    }
                }
                .readVerticalFlowSize(to: $size)
            }
        }
        .frame(height: size.height > 0 ? size.height : nil)
    }
}

private extension View {
    
    func readVerticalFlowSize(to size: Binding<CGSize>) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(
                key: VerticalFlowSizePreferenceKey.self,
                value: proxy.size
            )
        })
        .onPreferenceChange(VerticalFlowSizePreferenceKey.self) {
            size.wrappedValue = $0
        }
    }
    
}

private struct VerticalFlowSizePreferenceKey: PreferenceKey {
    
    static let defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        if next != .zero {
            value = next
        }
    }
}
