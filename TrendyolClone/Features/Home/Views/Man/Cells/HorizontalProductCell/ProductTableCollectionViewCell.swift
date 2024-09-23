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
    
    let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.2
        return view
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
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        return button
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
        contentView.addSubview(circleView)
        contentView.addSubview(combinedLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(shippingFreeView)
        
        shippingFreeView.addSubview(shippingLabel)
        circleView.addSubview(likeButton)
        
        circleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.width.height.equalTo(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(200)
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
            make.top.equalTo(shippingFreeView.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(40) // Adjust if you want more space
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(combinedLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.center.equalTo(circleView.snp.center)
            make.width.height.equalTo(10)
        }
    }
    
    func configure(product: Product) {
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
        
        attributedText.append(modelText) // Append the model string
        
        combinedLabel.attributedText = attributedText
        priceLabel.text =  "\(product.price)TL"
        imageView.kf.setImage(with: URL(string: product.thumbnail))
    }
}
