//
//  ProductTitleView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 29.09.2024.
//

import Foundation
import UIKit

class ProductTitleView: UITableViewCell {
    
    static let identifier: String = "ProductTitleView"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .init(16), weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let installmentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .init(12), weight: .bold)
        label.textColor = .red
        label.numberOfLines = 1
        return label
    }()
    
    let ratingView = RatingView()
    
    let favLabel = UILabel()
    
    let reviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        contentView.layer.borderWidth = 1
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(installmentLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(favLabel)
        contentView.addSubview(reviewLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        installmentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(250)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(installmentLabel.snp.trailing).offset(4)
            make.height.equalTo(20)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(installmentLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        favLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    fileprivate func setupReviewLabel() {
        let text = NSMutableAttributedString(string: " İncele ")
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "chevron.right")
        attachment.bounds = CGRect(x: -2, y: 0, width: 8, height: 8)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        
        text.append(attachmentString)
        
        reviewLabel.attributedText = text
        reviewLabel.backgroundColor = .lightGray.withAlphaComponent(0.2)
        reviewLabel.textAlignment = .center
        reviewLabel.layer.masksToBounds = true
        reviewLabel.layer.cornerRadius = 10
        reviewLabel.textColor = .black
        reviewLabel.font = .systemFont(ofSize: 12)
    }

    func set(title:String, model: String, rating: Double, price: Double) {
        let label = BrandAndModelLabel(brand: title, title: model, size: 12)
        ratingView.rating = rating
        
        
        contentView.addSubview(label)
        titleLabel.removeFromSuperview()
        titleLabel = label
        
        installmentLabel.text = "Peşin Fiyatına 3 Taksit (3 x \(price / 3))"
        
        setupReviewLabel()
        
        configure()  // Tekrar konfigüre etmek gerekli
    }
}

extension UILabel {
    var padding: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        set {
            
        }
    }
}
