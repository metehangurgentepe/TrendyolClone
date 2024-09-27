//
//  SearchCollectionViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
//    var slider: ImageSliderView = ImageSliderView(images: [])
    var slider = UIImageView()
    
    let likeButton = LikeButton(frame: .zero)

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        return label
    }()
    
    let starStackView = RatingView(frame: .zero)
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ThemeColor.primary
        return label
    }()
    
    let saleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        return label
    }()
    
    var freeShipping = ProductFreeShippingView(frame:.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.layer.cornerRadius = 4
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.backgroundColor = .white
        
        contentView.addSubview(slider)
        contentView.addSubview(likeButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteLabel)
        contentView.addSubview(starStackView)
        contentView.addSubview(saleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(freeShipping)
        
        
        slider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(40)
        }
        
        favoriteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(10)
        }
        
        starStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.top.equalTo(favoriteLabel.snp.bottom).offset(4)
            make.height.equalTo(12)
            make.width.equalTo(110)
        }
        
        saleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.top.equalTo(starStackView.snp.bottom).offset(4)
            make.height.equalTo(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(saleLabel.snp.top).offset(6)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(20)
        }
        
        freeShipping.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.width.equalTo(40)
            make.bottom.equalToSuperview().offset(-6)
        }
    }
    
    func configure(product: Product) {
        configureBrandAndModelLabel(product)
        
        slider.kf.setImage(with: URL(string: product.thumbnail))
        
        priceLabel.text = "\(product.price) TL"
        
        starStackView.rating = product.rating
        starStackView.reviewCount = product.reviews.count
        
        freeShipping.updateContent(title: "Hızlı Teslimat", image: UIImage(systemName: "car.fill")!, imageColor: .green)

        saleLabel.text = product.discountPercentage.isNaN ? nil : "\(product.discountPercentage) % indirim"
    }
    
    func configureBrandAndModelLabel(_ product: Product) {
        let attributedText = NSMutableAttributedString(
            string: product.brand ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium),
                .foregroundColor: UIColor.black
            ]
        )
        
        let modelText = NSAttributedString(
            string: " \( product.title)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .medium),
                .foregroundColor: UIColor.systemGray
            ]
        )
        
        attributedText.append(modelText)
        
        titleLabel.attributedText = attributedText
    }
    
    
}
