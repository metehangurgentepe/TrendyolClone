//
//  HomeSearchBar.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import Foundation
import UIKit
import SwiftUI

import Foundation
import UIKit

protocol HomeSearchBarDelegate: AnyObject {
    func navigate()
    func didTapReturn(query: String?)
    func showTableView()
    func tapCancelButton()
}

class HomeSearchBar: UIView, UITextFieldDelegate, UISearchBarDelegate {
    
    weak var searchBarDelegate: HomeSearchBarDelegate?
    
    // Search bar
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Marka, ürün veya kategori ara"
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Marka, ürün veya kategori ara", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        searchBar.tintColor = ThemeColor.primary
        searchBar.searchTextField.leftView?.tintColor = ThemeColor.primary
        return searchBar
    }()
    
    // Mail button
    let mailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "envelope"), for: .normal)
        button.tintColor = .black.withAlphaComponent(0.5)
        return button
    }()
    
    // Bell button with background view
    let bellButton: UIView = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = ThemeColor.primary
        backgroundView.layer.cornerRadius = 15
        backgroundView.clipsToBounds = true
        
        backgroundView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.centerY.equalTo(backgroundView.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        return backgroundView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBar, mailButton, bellButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        searchBar.searchTextField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        var width = ScreenSize.width - 10
        
        if #available(iOS 16.0, *) {
            width += 20
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(width)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        mailButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        
        bellButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarDelegate?.navigate()
        searchBar.searchTextField.becomeFirstResponder()
        
        stackView.removeArrangedSubview(mailButton)
        stackView.removeArrangedSubview(bellButton)
        
        mailButton.removeFromSuperview()
        bellButton.removeFromSuperview()
        
        searchBar.setShowsCancelButton(true, animated: true)
        
        self.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        
        mailButton.isHidden = false
        bellButton.isHidden = false
        
        stackView.addArrangedSubview(mailButton)
        stackView.addArrangedSubview(bellButton)
        
        self.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarDelegate?.didTapReturn(query: textField.text)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBarDelegate?.tapCancelButton()
    }
}
