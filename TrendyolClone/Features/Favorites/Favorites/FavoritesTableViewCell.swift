//
//  FavoritesTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier: String = "FavoritesTableViewCell"
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let brandName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    let productName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let ratingView = RatingView(frame: .zero)
    
    let freeShippingView = ProductFreeShippingView(title: "Kargo Bedava", image: UIImage(systemName: "shippingbox.fill")!, imageColor: .gray)
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = ThemeColor.primary
        return label
    }()
    
    let addToBasketButton = DefaultButton(frame: .zero, title: "Sepete Ekle", titleColor: ThemeColor.primary, backgroundColor: .white, borderWidth: 1)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(image)
        addSubview(brandName)
        addSubview(productName)
        addSubview(ratingView)
        addSubview(freeShippingView)
        addSubview(priceLabel)
        addSubview(addToBasketButton)
        
        
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(150)
            make.height.equalTo(200)
        }
        
        brandName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalTo(image.snp.trailing).offset(4)
            make.height.equalTo(22)
            make.trailing.equalToSuperview()
        }
        
        productName.snp.makeConstraints { make in
            make.leading.equalTo(brandName.snp.leading)
            make.trailing.equalToSuperview()
            make.top.equalTo(brandName.snp.bottom).offset(4)
            make.height.equalTo(20)
        }
        
        ratingView.snp.makeConstraints { make in
            make.leading.equalTo(brandName.snp.leading)
//            make.trailing.equalToSuperview()
            make.width.equalTo(100)
            make.top.equalTo(productName.snp.bottom).offset(4)
            make.height.equalTo(20)
        }
        
        freeShippingView.snp.makeConstraints { make in
            make.leading.equalTo(brandName.snp.leading)
            make.top.equalTo(ratingView.snp.bottom).offset(4)
//            make.trailing.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(brandName.snp.leading)
            make.top.equalTo(freeShippingView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.trailing.equalToSuperview()
        }
        
        addToBasketButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.width.equalTo(140)
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(product: Product) {
        brandName.text = product.brand?.uppercased()
        productName.text = product.title
        image.kf.setImage(with: URL(string: product.thumbnail))
        ratingView.rating = product.rating
        priceLabel.text = "\(product.price) TL"
        addToBasketButton.layer.borderColor = ThemeColor.primary.cgColor
    }
}
