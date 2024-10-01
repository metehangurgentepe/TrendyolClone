//
//  BrandAndModelLabel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 29.09.2024.
//

import UIKit

class BrandAndModelLabel: UILabel {
    
    init(brand: String?, title: String?, size: CGFloat) {
        super.init(frame: .zero)
        
        let attributedText = NSMutableAttributedString(
            string: brand ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: size, weight: .medium),
                .foregroundColor: UIColor.black
            ]
        )
        
        if let productTitle = title {
            let modelText = NSAttributedString(
                string: " \(productTitle)",
                attributes: [
                    .font: UIFont.systemFont(ofSize: size, weight: .medium),
                    .foregroundColor: UIColor.systemGray
                ]
            )
            attributedText.append(modelText)
        }
        
        self.attributedText = attributedText
        self.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(brand: String?, title: String?,size: CGFloat) {
        
        
    }
}

