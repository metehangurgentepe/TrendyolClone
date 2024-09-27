//
//  CategorySheetViewController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 26.09.2024.
//

import UIKit
import SnapKit

class CategorySheetViewController: UIViewController, UISearchBarDelegate {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Ara"
        searchBar.tintColor = ThemeColor.primary
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let clearButton = DefaultButton(frame: .zero, title: "Temizle", titleColor: .gray, backgroundColor: .white, borderWidth: 1)
    
    let applyButton = DefaultButton(frame: .zero, title: "Uygula", titleColor: .white, backgroundColor: ThemeColor.primary, borderWidth: 0)
    
    var categories: [String]
    
    init(categories: [String], placeholder: String) {
        self.categories = categories
        self.searchBar.placeholder = placeholder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        setupCollectionView()
        configureButtons()
    }
    
    func updateCategories(categories: [String], title: String) {
        self.categories = categories
        self.searchBar.placeholder = title
        self.collectionView.reloadData()
    }
    
    
    private func setupSearchBar() {
        searchBar.searchTextField.leftView?.tintColor = ThemeColor.primary
        searchBar.tintColor = ThemeColor.primary
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(CategorySheetCell.self, forCellWithReuseIdentifier: CategorySheetCell.identifier)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().inset(44)
        }
    }
    
    private func configureButtons() {
        
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        view.addSubview(clearButton)
        view.addSubview(applyButton)
        
        clearButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.width.equalTo((ScreenSize.width / 2) - 20)
        }
        
        applyButton.snp.makeConstraints { make in
            make.leading.equalTo(clearButton.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    @objc func clearButtonTapped() {
        
    }
    
    @objc func applyButtonTapped() {
        
    }
}

extension CategorySheetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySheetCell.identifier, for: indexPath) as! CategorySheetCell
        cell.configure(text: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 15, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySheetCell.identifier, for: indexPath) as! CategorySheetCell
        cell.isSelected.toggle()
    }
}
