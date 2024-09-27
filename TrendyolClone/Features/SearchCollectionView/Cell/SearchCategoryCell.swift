//
//  SearchCategoryCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 26.09.2024.
//

import Foundation
import UIKit

class SearchCategoryButtonCell: UICollectionViewCell {
    private let label = CapsuleLabel()
    
    static let identifier = "SearchCategoryButtonCell"
    var title: String?
    private let iconImageView = UIImageView()
    
    
    var icon: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var isSelected: Bool {
        didSet {
            configure(title: title ??  "", icon: icon)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.layer.borderColor = isSelected ? ThemeColor.primary.cgColor : UIColor.lightGray.cgColor
    }
    
    
    func setupUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func configure(title: String, icon: UIImage?) {
        self.title = title
        label.font = .preferredFont(forTextStyle: .caption2).withSize(12)
        label.text = title
        label.textColor = .black
//        label.backgroundColor = isSelected ? ThemeColor.primary : .white
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = isSelected ? ThemeColor.primary.cgColor : UIColor.lightGray.cgColor
        
        let attributedString = NSMutableAttributedString()
        
        
        self.icon = icon
        let attachment = NSTextAttachment()
        attachment.image = icon?.withRenderingMode(.alwaysTemplate)
        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.append(NSAttributedString(string: " \(title)"))
        
        
        label.attributedText = attributedString
        label.textAlignment = .center
        label.textColor = .black
    }
}

