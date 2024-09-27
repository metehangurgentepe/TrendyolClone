//
//  LikeButton.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit

class LikeButton: UIButton {
    
    var image = UIImage(systemName: "heart")
    
    override var isSelected: Bool {
        didSet{
            let fillImage = UIImage(named: "heart.fill")
            isSelected ? setImage(fillImage, for: .selected) : setImage(image, for: .normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tintColor = .black
        layer.cornerRadius = frame.size.width / 2
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.3
        
        clipsToBounds = true
        
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 3, left: 2, bottom: 3, right: 3)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
}
