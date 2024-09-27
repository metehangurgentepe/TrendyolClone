//
//  ForYouCollectionViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit
import Kingfisher

import UIKit

class ProductTableCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ForYouCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let combinedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = ThemeColor.primary
        return label
    }()
    
    let shippingFreeView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.clipsToBounds = true
        return view
    }()
    
    let shippingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.text = "Kargo Bedava"
        return label
    }()
    
    let likeButton = LikeButton()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .systemGray
        view.trackTintColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
        
        contentView.addSubview(imageView)
        contentView.addSubview(combinedLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(shippingFreeView)
        
        shippingFreeView.addSubview(shippingLabel)
        contentView.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.width.height.equalTo(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.leading.trailing.equalToSuperview()
        }
        
        shippingFreeView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        shippingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shippingFreeView.snp.centerX)
            make.centerY.equalTo(shippingFreeView.snp.centerY)
        }
        
        combinedLabel.snp.makeConstraints { make in
            make.top.equalTo(shippingFreeView.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(combinedLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(2)
            make.height.equalTo(20)
        }
    }
    
    func configureFlashSaleContentView() {
        let flashIcon = UIImageView(image: UIImage(named: "flash"))
        
        let label = UILabel()
        label.text = "27 ürün satıldı"
        label.textColor = .black
        label.font = .systemFont(ofSize: 8, weight: .light)
        
        progressView.progress = 0.2
        
        contentView.addSubview(progressView)
        contentView.addSubview(flashIcon)
        contentView.addSubview(label)
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(2)
            make.leading.equalTo(priceLabel.snp.leading)
            make.trailing.equalToSuperview().inset(2)
        }
        
        flashIcon.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.leading)
            make.width.height.equalTo(16)
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.leading.equalTo(flashIcon.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(2)
            make.height.equalTo(16)
        }
    }
    
    fileprivate func configureSmallerContentView(_ product: Product) {
        contentView.layer.cornerRadius = 4
        
        likeButton.removeFromSuperview()
        
        imageView.snp.remakeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(2)
        }
        
        shippingFreeView.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        shippingLabel.font = .systemFont(ofSize: 6, weight: .bold)
        priceLabel.font = .systemFont(ofSize: 9, weight: .bold)
        
        combinedLabel.snp.makeConstraints { make in
            make.top.equalTo(shippingFreeView.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(2)
            make.trailing.equalToSuperview().inset(2)
            make.height.equalTo(15)
        }
        
        let attributedText = NSMutableAttributedString(
            string: product.brand ?? "",
            attributes: [
                .font: UIFont.systemFont(ofSize: 6, weight: .medium),
                .foregroundColor: UIColor.black
            ]
        )
        
        let modelText = NSAttributedString(
            string: " \( product.title)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 6, weight: .medium),
                .foregroundColor: UIColor.systemGray
            ]
        )
        
        attributedText.append(modelText)
        
        combinedLabel.attributedText = attributedText
    }
    
    func configure(product: Product, isFlashSale: Bool, smaller: Bool?) {
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
        
        combinedLabel.attributedText = attributedText
        priceLabel.text =  "\(product.price)TL"
        imageView.kf.setImage(with: URL(string: product.thumbnail))
        
        if isFlashSale {
            configureFlashSaleContentView()
        }
        
        if smaller == true {
            configureSmallerContentView(product)
        }
    }
}
