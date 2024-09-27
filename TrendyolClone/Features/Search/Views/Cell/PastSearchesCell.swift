//
//  PastSearchesCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 24.09.2024.
//

import UIKit

protocol PastSearchesCellDelegate: AnyObject {
    func didTapXButton(for cell: PastSearchesCell)
}

class PastSearchesCell: UITableViewCell {
    static let identifier = "PastSearchesCell"
    let queryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black.withAlphaComponent(0.8)
        return label
    }()
    
    let xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    var delegate: PastSearchesCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(query: String) {
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        queryLabel.text = query
        
        contentView.addSubview(xButton)
        contentView.addSubview(queryLabel)
        
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        contentView.layer.borderWidth = 0.5
        
        xButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        queryLabel.snp.makeConstraints { make in
            make.leading.equalTo(xButton.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func xButtonTapped() {
        delegate?.didTapXButton(for: self)
    }
}
