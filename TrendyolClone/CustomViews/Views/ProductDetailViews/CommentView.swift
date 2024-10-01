//
//  CommentView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 30.09.2024.
//

import Foundation
import UIKit

class CommentView: UIView {
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.text =  "Ürün çok güzel. Beğenerek aldım. Siz de alabilirsiniz."
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "Beden 42"
        return label
    }()
    
    let sellerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.text = "Satıcı Pointspor"
        return label
    }()
    let starView = StarView(frame: .zero)
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "S** M**"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    var sellerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layer.cornerRadius = 4
        backgroundColor = .lightGray.withAlphaComponent(0.3)
        starView.setRating(4.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(starView)
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(sizeLabel)
        addSubview(sellerLabel)
        
        
        starView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(6)
            make.height.equalTo(16)
            make.width.equalTo(100)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(starView.snp.top)
            make.trailing.equalToSuperview().inset(6)
            make.height.equalTo(16)
            make.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(starView.snp.bottom).offset(4)
            make.leading.equalTo(starView.snp.leading)
            make.height.equalTo(10)
            make.trailing.equalTo(starView.snp.trailing)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(starView.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.trailing.equalToSuperview().inset(6)
            make.height.equalTo(60)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.leading.equalTo(starView.snp.leading)
            make.top.equalTo(commentLabel.snp.bottom).offset(2)
            make.width.equalTo(100)
            make.height.equalTo(10)
        }
        
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        likeButton.tintColor = .gray
        
        let warningButton = UIButton()
        warningButton.setImage(UIImage(systemName: "exclamationmark.bubble.fill"), for: .normal)
        warningButton.tintColor = .gray
        
        sellerStackView = UIStackView(arrangedSubviews: [sellerLabel, likeButton, warningButton])
        sellerStackView.axis = .horizontal
        sellerStackView.distribution = .fill
        sellerStackView.alignment = .center
        sellerStackView.spacing = 8
        
        addSubview(sellerStackView)
        
        
        sellerStackView.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(6)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
}
