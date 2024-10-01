//
//  ProductFreeShippingView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit

class ProductFreeShippingView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.9)
        label.font = .preferredFont(forTextStyle: .headline).withSize(8)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imageView = UIImageView()
    
    var imageColor: UIColor?
    
    convenience init(title: String, image: UIImage, imageColor: UIColor) {
        self.init(frame: .zero)
        updateContent(title: title, image: image, imageColor: imageColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        
        imageView.tintColor = imageColor
        
        backgroundColor = imageColor?.withAlphaComponent(0.2)
    
        addSubview(titleLabel)
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.top.equalToSuperview().offset(2)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

extension ProductFreeShippingView {
    func updateContent(title: String, image: UIImage, imageColor: UIColor) {
        // Update the title, image, and image color here
        self.titleLabel.text = title
        self.imageView.image = image
        self.imageView.tintColor = imageColor
        
        backgroundColor = imageColor.withAlphaComponent(0.1)
    }
}
