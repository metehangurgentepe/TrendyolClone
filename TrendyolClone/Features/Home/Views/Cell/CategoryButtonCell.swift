//
//  CategoryButtonCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import UIKit

class CapsuleLabel: UILabel {
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius: CGFloat = bounds.height / 2
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.borderWidth = 1
    }
}

class CategoryButtonCell: UICollectionViewCell {
    private let label = CapsuleLabel()
    
    static let identifier = "CategoryButtonCell"
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
        label.textColor = isSelected ? .white : .black
        label.backgroundColor = isSelected ? ThemeColor.primary : .white
        label.textAlignment = .center
        label.layer.borderWidth = isSelected ? 0 : 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        
        let attributedString = NSMutableAttributedString()
        
        if title == Categories.category.rawValue{
            let attachment = NSTextAttachment()
            let image = UIImage(systemName: "line.3.horizontal")
            attachment.image = image!.withRenderingMode(.alwaysTemplate)
            attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: " \(title)"))
        }else if icon == UIImage(systemName: "magnifyingglass") {
            let attachment = NSTextAttachment()
            attachment.image = icon!.withRenderingMode(.alwaysTemplate)
            attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: " \(title)"))
        } else if let icon {
            self.icon = icon
            let attachment = NSTextAttachment()
            attachment.image = icon.withRenderingMode(.alwaysTemplate)
            attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            
            attributedString.append(NSAttributedString(attachment: attachment))
            attributedString.append(NSAttributedString(string: " \(title)"))
        }
        else {
            attributedString.append(NSAttributedString(string: title))
        }
        
        label.attributedText = attributedString
        label.textAlignment = .center
        label.textColor = isSelected ? .white : .black
    }
}

