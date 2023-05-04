//
//  SVGImageProcessor.swift
//  VendorsApp
//
//  Created by Артур Заволович on 04.05.2023.
//

import UIKit
import Kingfisher
import SVGKit

struct SVGImageProcessor: ImageProcessor {
    var identifier: String = "com.vendorsapp.webpprocessor"
    
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
            case let .image(image):
                return image
            case let .data(data):
                let imsvg = SVGKImage(data: data)
                return imsvg?.uiImage
        }
    }
}
