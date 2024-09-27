//
//  UIImage+Ext.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import Foundation
import UIKit


extension UIImage{
    func resizeImage(targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        return resizedImage
    }
}
