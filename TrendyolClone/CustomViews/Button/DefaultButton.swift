//
//  DefaultButton.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 26.09.2024.
//

import UIKit

class DefaultButton: UIButton {

    init(frame: CGRect, title: String, titleColor:UIColor, backgroundColor:UIColor, borderWidth:CGFloat) {
        super.init(frame: frame)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = borderWidth
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 4
    }
    
}
