//
//  CollectionCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 2.10.2024.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell {
    static let identifier = "CollectionCell"
    let collectionVC = CollectionsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(products: [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(products: [Product]) {
//        favoritesVC.products = products
        let collectionsView = collectionVC.view!
        
        
        contentView.addSubview(collectionsView)
        collectionsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
