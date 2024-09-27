//
//  HomeSearchBar.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import Foundation
import UIKit

protocol HomeSearchBarDelegate: AnyObject{
    func navigate()
    func didTapReturn(query: String?)
    func showTableView()
    func tapCancelButton()
}

class HomeSearchBar: UIView, UITextFieldDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    
    weak var searchBarDelegate: HomeSearchBarDelegate?
    
    let mailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "envelope"), for: .normal)
        button.tintColor = .black.withAlphaComponent(0.5)
        return button
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        searchBar.searchTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupShowButtons() {
        searchBar.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.lessThanOrEqualTo(ScreenSize.width - 80)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        mailButton.snp.makeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        bellButton.snp.makeConstraints { make in
            make.leading.equalTo(mailButton.snp.trailing).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    fileprivate func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Marka, ürün veya kategori ara"
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Marka, ürün veya kategori ara", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        searchBar.tintColor = ThemeColor.primary
        
        if let image = UIImage(systemName: "magnifyingglass") {
            let imageView = UIImageView(image: image)
            imageView.tintColor = ThemeColor.primary
            searchBar.searchTextField.leftView = imageView
        }
    }
    
    func configure() {
        addSubview(searchBar)
        
        self.searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        addSubview(mailButton)
        addSubview(bellButton)
        setupShowButtons()
        
        
        setupSearchBar()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBar.searchTextField.becomeFirstResponder()
        searchBarDelegate?.navigate()
        
        self.mailButton.removeFromSuperview()
        self.bellButton.removeFromSuperview()
        
        self.searchBar.setShowsCancelButton(true, animated: true)
        
        self.searchBar.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        addSubview(mailButton)
        addSubview(bellButton)
        
        self.searchBar.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(40)
            make.width.lessThanOrEqualTo(ScreenSize.width - 80)
            make.bottom.equalToSuperview()
        }
        
        mailButton.snp.remakeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        bellButton.snp.remakeConstraints { make in
            make.leading.equalTo(mailButton.snp.trailing).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBarDelegate?.didTapReturn(query: textField.text)
        textField.text = ""
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBarDelegate?.tapCancelButton()
    }
}
