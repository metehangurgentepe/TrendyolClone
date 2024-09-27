//
//  CategorySheetCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 26.09.2024.
//

import UIKit

class CategorySheetCell: UICollectionViewCell {
    static let identifier = "CategorySheetCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black.withAlphaComponent(0.7)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    var text: String?
    
    override var isSelected: Bool {
        didSet{
            configure(text: text ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    func configure(text: String) {
        self.text = text
        imageView.layer.cornerRadius = 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = isSelected ? 0 : 0.5
        
        imageView.image = isSelected ? UIImage(named: "checkmark.square.fill") : nil
        
        label.text = text
    }
}
