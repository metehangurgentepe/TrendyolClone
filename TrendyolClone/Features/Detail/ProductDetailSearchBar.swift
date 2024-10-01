//
//  ProductDetailSearchBar.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 29.09.2024.
//

import Foundation


import UIKit

protocol ProductDetailSearchBarTitleViewDelegate: AnyObject {
    func searchBarDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarDidEndEditing(_ searchBar: UISearchBar)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func backButtonTapped()
    func navigate()
    func search(_ query: String)
    func showCollectionView()
}

class ProductDetailSearchBarTitleView: UIView, UITextFieldDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let basketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "basket"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    weak var searchBarDelegate: ProductDetailSearchBarTitleViewDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.backgroundImage = UIImage()
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Marka, ürün veya kategori ara", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        searchBar.tintColor = ThemeColor.primary
        
        if let image = UIImage(systemName: "magnifyingglass") {
            let imageView = UIImageView(image: image)
            imageView.tintColor = ThemeColor.primary
            searchBar.searchTextField.leftView = imageView
        }
    }
    
    private func configure() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(basketButton)
        
        setupSearchBar()
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.widthAnchor.constraint(equalToConstant: ScreenSize.width - 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            shareButton.widthAnchor.constraint(equalToConstant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            
            basketButton.widthAnchor.constraint(equalToConstant: 20),
            basketButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func backButtonTapped() {
        self.searchBarDelegate?.backButtonTapped()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(true, animated: true)
        self.searchBarDelegate?.navigate()
        
        stackView.removeArrangedSubview(shareButton)
        stackView.removeArrangedSubview(basketButton)
        
        shareButton.removeFromSuperview()
        basketButton.removeFromSuperview()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchBarDelegate?.navigate()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchBarDelegate?.search(textField.text!)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        self.searchBarDelegate?.showCollectionView()
        
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(basketButton)
    }
}
