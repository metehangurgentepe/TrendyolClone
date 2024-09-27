//
//  VerticalPhotoCollectionViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 24.09.2024.
//

import UIKit

class VerticalPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VerticalPhotoCollectionViewCell"
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        contentView.layer.cornerRadius = 2
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(product: Product) {
        imageView.kf.setImage(with: URL(string: product.thumbnail))
    }
}
