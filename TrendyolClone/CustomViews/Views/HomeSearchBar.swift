//
//  HomeSearchBar.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import Foundation
import UIKit

protocol HomeSearchBarDelegate: AnyObject {
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
    
    let bellButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = ThemeColor.primary
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        searchBar.searchTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configure() {
        print(frame.width,"width")
        // Setup the search bar
        setupSearchBar()
        
        // Add buttons to buttonStackView
        buttonStackView.addArrangedSubview(mailButton)
        buttonStackView.addArrangedSubview(bellButton)
        
        // Add search bar and button stack to the main stack view
        mainStackView.addArrangedSubview(searchBar)
        mainStackView.addArrangedSubview(buttonStackView)
        
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(ScreenSize.width - 20)
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    fileprivate func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Marka, ürün veya kategori ara"
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Marka, ürün veya kategori ara",
            attributes: [.font: UIFont.systemFont(ofSize: 14)]
        )
        searchBar.tintColor = ThemeColor.primary
        if let image = UIImage(systemName: "magnifyingglass") {
            let imageView = UIImageView(image: image)
            imageView.tintColor = ThemeColor.primary
            searchBar.searchTextField.leftView = imageView
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBarDelegate?.navigate()
        
        buttonStackView.isHidden = true
        searchBar.setShowsCancelButton(true, animated: true)
        
        searchBar.snp.remakeConstraints { make in
            make.width.lessThanOrEqualTo(ScreenSize.width - 20)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        buttonStackView.isHidden = false
        
        searchBar.snp.remakeConstraints { make in
            make.width.lessThanOrEqualTo(ScreenSize.width - 80)
        }
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
