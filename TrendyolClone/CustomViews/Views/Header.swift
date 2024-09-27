//
//  Header.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

class Header: UITableViewHeaderFooterView {
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "Header"
        return label
    }()
    
    let seeAllButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(ThemeColor.primary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.isHidden = true
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    convenience init(title: String, seeAllButtonTitle: String?, titleColor: UIColor?, buttonColor: UIColor?) {
        self.init(reuseIdentifier: nil)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        seeAllButton.setTitleColor(buttonColor, for: .normal)
        seeAllButton.setTitle(seeAllButtonTitle, for: .normal)
        seeAllButton.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(seeAllButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.top.equalToSuperview()
            make.width.equalTo(300)
            
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.height.equalTo(35)
        }
    }
}
