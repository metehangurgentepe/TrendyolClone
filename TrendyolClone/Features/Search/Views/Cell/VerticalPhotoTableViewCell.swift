//
//  VerticalPhotoTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 24.09.2024.
//

import UIKit

class VerticalPhotoTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let identifier: String = "VerticalPhotoTableViewCell"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        
        contentView.backgroundColor = ThemeColor.bgColor
        
        collectionView.register(VerticalPhotoCollectionViewCell.self, forCellWithReuseIdentifier: VerticalPhotoCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.collectionViewLayout = layout
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
        }
        
//        setNeedsLayout()
    }
}

extension VerticalPhotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalPhotoCollectionViewCell.identifier, for: indexPath) as! VerticalPhotoCollectionViewCell
        cell.configure(product: products![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 60, height: 80)
    }
}
