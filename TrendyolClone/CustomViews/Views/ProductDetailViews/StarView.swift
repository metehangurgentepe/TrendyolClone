//
//  StarView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 30.09.2024.
//

import Foundation
import UIKit

class StarView: UIView {
    
    private var starImageViews: [UIImageView] = []
    private let starCount: Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStars() {
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4
        starStackView.distribution = .fillEqually
        
        for _ in 0..<starCount {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = ThemeColor.starColor
            starImageViews.append(starImageView)
            starStackView.addArrangedSubview(starImageView)
        }
        
        addSubview(starStackView)
        
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            starStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            starStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            starStackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setRating(_ rating: Double) {
        for (index, starImageView) in starImageViews.enumerated() {
            if Double(index) < rating {
                starImageView.tintColor = ThemeColor.starColor
            } else {
                starImageView.tintColor = .gray 
            }
        }
    }
}
