//
//  CategoryTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 24.09.2024.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    var categoryController = CategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: Categories.allCases.map{$0.rawValue}, icons: [])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        categoryController.icons = Array(repeating: UIImage(systemName: "magnifyingglass"), count: Categories.allCases.count)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.backgroundColor = ThemeColor.bgColor
        
        let categoryView = categoryController.view!
        contentView.addSubview(categoryView)
        
        categoryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
