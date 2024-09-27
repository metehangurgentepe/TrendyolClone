//
//  PopularCampaignsTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit

class PopularCampaignsTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let identifier = "PopularCampaignsTableViewCell"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var categoryController = CategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: Categories.allCases.map{ $0.rawValue }, icons: [])
    
    var products: [Product]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(product: [Product]) {
        self.products = product
        
        categoryController.categories = Categories.allCases.map{ $0.rawValue }
        
        let categoryView = categoryController.view!
        
        collectionView.register(PopularCampaignsCollectionViewCell.self, forCellWithReuseIdentifier: PopularCampaignsCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.collectionViewLayout = layout
        
        contentView.addSubview(categoryView)
        contentView.addSubview(collectionView)
        
        categoryView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
        }
        
        setNeedsLayout()
    }
    
    func configureCategoryButtons() {
        //        categoryController.delegate = self
        
        //        categoryController.collectionView.selectItem(at: [0,1], animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        
    }
}


extension PopularCampaignsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCampaignsCollectionViewCell.identifier, for: indexPath) as! PopularCampaignsCollectionViewCell
        cell.configure(product: products![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: 180)
    }
}

