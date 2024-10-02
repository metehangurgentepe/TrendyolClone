//
//  FavoritesController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var products: [Product] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    let tableView = UITableView()
    let categoryController = CategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: ["Kuponlu Ürünler"], icons: [UIImage(systemName: "ticket")!])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
    private func setupTitleView() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Marka, ürün, kategori ara"
        searchBar.tintColor = ThemeColor.primary
        searchBar.searchTextField.leftView?.tintColor = ThemeColor.primary
        searchBar.layer.borderWidth = 0
        searchBar.backgroundImage = UIImage() 
        
        let button = UIButton()
        button.setTitle("Ürün Seç", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = ThemeColor.primary
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        let stackView = UIStackView(arrangedSubviews: [searchBar,button])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.backgroundColor = .white
        
        let categoryView = categoryController.view!
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(stackView)
        view.addSubview(categoryView)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(250)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(ScreenSize.width)
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(view.snp.top)
        }
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        cell.configure(product: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenSize.height * 0.25
    }

}
