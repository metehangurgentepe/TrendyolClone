//
//  InfiniteScrollsHorizontalTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 30.09.2024.
//

import UIKit

class InfiniteScrollsVerticalTableViewCell: UITableViewCell {
    static let identifier = "InfiniteScrollsVerticalTableViewCell"
    
    var collectionView: UICollectionView!
    var products: [Product] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        let titleLabel = UILabel()
        titleLabel.text = "Daha Fazla Öneri"
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .lightGray
        
        let grayLine = UIView()
        grayLine.backgroundColor = .gray.withAlphaComponent(0.2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let width = ScreenSize.width / 2
        layout.itemSize = CGSize(width: width - 20 , height: 225)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = ThemeColor.bgColor
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(grayLine)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().inset(10)
        }
        
        grayLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(contentView).inset(10)
        }
    }
    
    func configure(products: [Product]) {
        self.products = products
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }

}

extension InfiniteScrollsVerticalTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let id = recipesArr[indexPath.row].id
//        delegate?.didSelectRecipe(recipeId: id)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (ScreenSize.width / 2) - 20, height: ScreenSize.height / 2)
    }
}


extension InfiniteScrollsVerticalTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.configure(product: products[indexPath.item])
        return cell
    }
}
