//
//  FavoritesCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import Foundation
import UIKit

class FavoritesCell: UICollectionViewCell {
    static let identifier = "FavoritesCell"
    let favoritesVC = FavoritesController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(products: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(products: [Product]) {
        favoritesVC.products = products
        let favoritesView = favoritesVC.view!
        
        
        contentView.addSubview(favoritesView)
        favoritesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
