//
//  ForYouTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ForYouTableViewCell"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var isFlashSale: Bool = false
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flash_bgimage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var products: [Product]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        collectionView.register(ProductTableCollectionViewCell.self, forCellWithReuseIdentifier: ProductTableCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ThemeColor.bgColor
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(products: [Product], isFlashSale: Bool) {
        self.products = products
        collectionView.reloadData()
        
        if isFlashSale {
            contentView.insertSubview(backgroundImageView, belowSubview: collectionView)
            
            backgroundImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(-30)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(contentView.snp.centerY)
            }
        }
        setNeedsLayout()
    }
}

extension ProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductTableCollectionViewCell.identifier, for: indexPath) as! ProductTableCollectionViewCell
        cell.configure(product: products![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: 300)
    }
}
