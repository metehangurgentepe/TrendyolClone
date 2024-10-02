//
//  ListCollectionViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 2.10.2024.
//

import Foundation
import UIKit


class ListCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "ListCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    let numberOfProductsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    let centerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.borderWidth = 1.0
        
        contentView.addSubview(centerLineView)
        contentView.addSubview(bottomLineView)
        contentView.addSubview(imageView)
        contentView.addSubview(imageView2)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberOfProductsLabel)
        
        centerLineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(100)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.equalTo(contentView.snp.centerX)
            make.height.equalTo(100)
        }
        
        imageView2.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.centerX)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLineView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        numberOfProductsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(list: ListModel) {
        imageView.kf.setImage(with: URL(string:list.image1))
        imageView2.kf.setImage(with: URL(string:list.image2))
        titleLabel.text = list.title
        numberOfProductsLabel.text = "\(list.countOfItems) Ürün"
    }
}
