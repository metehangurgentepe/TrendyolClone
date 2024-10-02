//
//  CollectionsController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 2.10.2024.
//

import Foundation
import UIKit


class CollectionsController: UIViewController {
    let listButton = DefaultButton(frame: .zero, title: "Listelerim", titleColor: ThemeColor.primary, backgroundColor: .white, borderWidth: 1)
    let savesButton = DefaultButton(frame: .zero, title: "Kaydettiklerim", titleColor: ThemeColor.primary, backgroundColor: .white, borderWidth: 1)
    
    let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let savesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var list: [ListModel] = [ListModel(image1: "https://cdn.dummyjson.com/products/images/groceries/Lemon/1.png",
                                       image2: "https://cdn.dummyjson.com/products/images/kitchen-accessories/Boxed%20Blender/thumbnail.png", title: "Beğendiklerim", countOfItems: 2)]
    
    var saveList: [ListModel] = [ListModel(image1: "https://cdn.dummyjson.com/products/images/kitchen-accessories/Chopping%20Board/1.png",
                                          image2: "https://cdn.dummyjson.com/products/images/kitchen-accessories/Citrus%20Squeezer%20Yellow/1.png", title: "Mutfak için", countOfItems: 2)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listButton.isSelected = true
        
        setupButtons()
        setupListCollectionView()
        setupSavesCollectionView()
        
        listCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        savesCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
    
    func setupSavesCollectionView() {
        savesCollectionView.delegate = self
        savesCollectionView.dataSource = self
        
        view.addSubview(savesCollectionView)
        
        savesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setupListCollectionView() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        view.addSubview(listCollectionView)
        
        listCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setupButtons() {
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        savesButton.addTarget(self, action: #selector(savesButtonTapped), for: .touchUpInside)
        
        listButton.isSelected = true
        updateButtonAppearance()
        
        view.backgroundColor = ThemeColor.bgColor
        
        let stackView = UIStackView(arrangedSubviews: [listButton, savesButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(35)
        }
    }
    
    @objc func listButtonTapped() {
        listButton.isSelected = true
        savesButton.isSelected = false
        updateButtonAppearance()
    }

    @objc func savesButtonTapped() {
        listButton.isSelected = false
        savesButton.isSelected = true
        updateButtonAppearance()
    }

    func updateButtonAppearance() {
        if listButton.isSelected {
            listButton.layer.borderColor = ThemeColor.primary.cgColor
            listButton.setTitleColor(ThemeColor.primary, for: .normal)
            
            listCollectionView.isHidden = false
            savesCollectionView.isHidden = true
            
            listCollectionView.reloadData()
            listCollectionView.backgroundColor = .clear
        } else {
            listButton.layer.borderColor = UIColor.gray.cgColor
            listButton.setTitleColor(.gray, for: .normal)
        }
        
        if savesButton.isSelected {
            savesButton.layer.borderColor = ThemeColor.primary.cgColor
            savesButton.setTitleColor(ThemeColor.primary, for: .normal)
            
            savesCollectionView.backgroundColor = .clear
            savesCollectionView.reloadData()
            listCollectionView.isHidden = true
            savesCollectionView.isHidden = false
            
        } else {
            savesButton.layer.borderColor = UIColor.gray.cgColor
            savesButton.setTitleColor(.gray, for: .normal)
        }
    }
}


extension CollectionsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case listCollectionView:
            return list.count
        case savesCollectionView:
            return saveList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case listCollectionView:
            let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
            cell.configure(list: self.list[indexPath.item])
            return cell
        case savesCollectionView:
            let cell = savesCollectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
            cell.configure(list: self.saveList[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case listCollectionView:
            return .init(width: (ScreenSize.width / 2) - 15, height: (ScreenSize.width / 2) - 15)
        case savesCollectionView:
            return .init(width: (ScreenSize.width / 2) - 15, height: (ScreenSize.width / 2) - 15)
        default:
            return .init(width: (ScreenSize.width / 2) - 15, height: (ScreenSize.width / 2) - 15)

        }
    }
}
