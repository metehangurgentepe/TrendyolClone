//
//  SearchBarTitleView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

//
//  SearchBarTitleView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit

protocol SearchBarViewDelegate: AnyObject {
    func searchBarDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarDidEndEditing(_ searchBar: UISearchBar)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    func backButtonTapped()
    func navigate()
    func search(_ query: String)
    func showCollectionView()
}

class SearchBarTitleView: UIView, UITextFieldDelegate, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    weak var searchBarDelegate: SearchBarViewDelegate?
    
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
        
        // Add stack view to the main view
        addSubview(stackView)
        
        // Add back button and search bar to the stack view
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(searchBar)
        
        setupSearchBar()
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        // Disable autoresizing mask
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // StackView constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.widthAnchor.constraint(equalToConstant: ScreenSize.width - 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // BackButton constraints
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // SearchBar constraints (make it expand to fill the remaining space)
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
    }
}
