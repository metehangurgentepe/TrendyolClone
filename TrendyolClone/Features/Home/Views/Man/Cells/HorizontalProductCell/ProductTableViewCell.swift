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
    
    var categoryController = CategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: [], icons: [])
    
    var isFlashSale: Bool = false
    
    var smaller: Bool = false
    
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
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = ThemeColor.bgColor
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(products: [Product], isFlashSale: Bool, willCategoryShow: Bool,smaller: Bool) {
        self.products = products
        self.isFlashSale = isFlashSale
        self.smaller = smaller
        collectionView.reloadData()
        
        backgroundImageView.isHidden = !isFlashSale
        
        if isFlashSale {
            collectionView.backgroundColor = .clear
            contentView.insertSubview(backgroundImageView, belowSubview: collectionView)
            
            backgroundImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(-30)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(contentView.snp.centerY)
            }
        }
        
        if willCategoryShow {
            collectionView.backgroundColor = .clear
            categoryController.categories = Categories.allCases.map{ $0.rawValue }
            let categoryView = categoryController.view!
            
            contentView.addSubview(categoryView)
            
            categoryView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(4)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(30)
            }
            
            collectionView.snp.remakeConstraints { make in
                make.top.equalTo(categoryView.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
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
        cell.configure(product: products![indexPath.item], isFlashSale: isFlashSale, smaller: smaller)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isFlashSale{
            return .init(width: 150, height: 330)
        } else if smaller{
            return .init(width: 90, height: 120)
        }else {
            return .init(width: 150, height: 300)
        }
        
    }
}
