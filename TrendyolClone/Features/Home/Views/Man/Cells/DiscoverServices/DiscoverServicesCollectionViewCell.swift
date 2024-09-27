//
//  DiscoverServicesCollectionViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit

class DiscoverServicesCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "DiscoverServicesCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    let campaignLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let campaignBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.6) // Semi-transparent color
        view.clipsToBounds = true
        return view
    }()
    
    let squareView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    var bgColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        squareView.backgroundColor = .red
        contentView.addSubview(squareView)
        contentView.addSubview(titleLabel)
        
        squareView.addSubview(imageView)
        squareView.addSubview(campaignBackgroundView)
        squareView.addSubview(campaignLabel)
        
        
        squareView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(squareView.snp.height).multipliedBy(0.8)
        }
        
        
        campaignBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(squareView)
            make.height.equalTo(20)
        }
        
        
        campaignLabel.snp.makeConstraints { make in
            make.centerX.equalTo(campaignBackgroundView.snp.centerX)
            make.centerY.equalTo(campaignBackgroundView.snp.centerY)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(squareView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        campaignBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        campaignBackgroundView.layer.cornerRadius = 10
    }
    
    func configure(service: Services, color: UIColor) {
        titleLabel.text = service.title
        imageView.image = service.image
        campaignLabel.text = service.campaignTitle
        campaignBackgroundView.backgroundColor = color
        squareView.backgroundColor = color.withAlphaComponent(0.2)
        
        if color == UIColor.clear {
            imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(squareView.snp.height)
            }
        }
        
        setNeedsLayout()
    }
}
