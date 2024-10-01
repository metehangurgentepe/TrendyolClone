//
//  MenuController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import Foundation
import UIKit

protocol FavoriteMenuControllerDelegate: AnyObject {
    func didTapMenuItem(indexPath: IndexPath)
}

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate var menuItems = [
        "Favorilerim",
        "Koleksiyonlarım"
    ]
    
    var menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = ThemeColor.primary
        return v
    }()
    
    var delegate: FavoriteMenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuBar)
        
        view.bringSubviewToFront(menuBar)
        
        menuBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(ScreenSize.width / 2)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.label.text = menuItems[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return .init(width: width/2, height: view.frame.height)
    }
}
