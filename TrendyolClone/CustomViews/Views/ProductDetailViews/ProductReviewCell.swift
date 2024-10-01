//
//  ProductReviewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 30.09.2024.
//

import UIKit

class ProductReviewCell: UITableViewCell {
    static let identifier: String = "ProductReviewCell"
    
    let ratingView = RatingView(frame: .zero)
    let titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .gray
        titleLabel.text = "Ürün Değerlendirmeleri"
        
        let seeAllButton = UIButton()
        seeAllButton.setTitle("Tümünü Gör", for: .normal)
        seeAllButton.setTitleColor(ThemeColor.primary, for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        seeAllButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        seeAllButton.tintColor = ThemeColor.primary
        
        seeAllButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        seeAllButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
    
        seeAllButton.semanticContentAttribute = .forceRightToLeft
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,seeAllButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()
    
    let commentView = CommentView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let borderView = UIView()
        borderView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.5
        
        ratingView.rating = 4.5
        
        contentView.addSubview(titleStackView)
        contentView.addSubview(ratingView)
        contentView.addSubview(commentView)
        contentView.addSubview(borderView)
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(-2)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        commentView.snp.makeConstraints { make in
            make.top.equalTo(ratingView.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(150)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
