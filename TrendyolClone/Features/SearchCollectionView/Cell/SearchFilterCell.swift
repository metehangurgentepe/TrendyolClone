//
//  SearchFilterCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 26.09.2024.
//

import Foundation
import UIKit

protocol SearchControllerDelegate: AnyObject {
    func didTapMenuItem(indexPath: IndexPath)
    func deselectMenuItem(indexPath: IndexPath)
}

class SearchCategoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var categories: [String]
    var delegate: SearchControllerDelegate?
    var icons: [UIImage?]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var selectedCell = [IndexPath]()

    
    init(collectionViewLayout layout: UICollectionViewLayout, categories: [String], icons: [UIImage]) {
        self.categories = categories
        self.icons = icons.map { $0 as UIImage? }
        
        if icons.count < categories.count {
            let difference = categories.count - icons.count
            self.icons?.append(contentsOf: Array(repeating: nil, count: difference))
        } else if icons.count > categories.count {
            self.icons = Array(icons.prefix(categories.count))
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(SearchCategoryButtonCell.self, forCellWithReuseIdentifier: SearchCategoryButtonCell.identifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 70, height: 35)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = collectionView.cellForItem(at: indexPath)
        if item?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            delegate?.deselectMenuItem(indexPath: indexPath)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            return true
        }

        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoryButtonCell.identifier, for: indexPath) as! SearchCategoryButtonCell
        cell.configure(title: categories[indexPath.item], icon: icons![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12)]).width + 30
        return CGSize(width: cellWidth, height: 30.0)
    }
}
