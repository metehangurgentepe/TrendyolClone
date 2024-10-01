//
//  HomeVC.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import UIKit
import Hero
import SwiftUI

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, MenuControllerDelegate, HomeCellDelegate {
    let categories = Categories.allCases
    
    let categoryController = CategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: Categories.allCases.map { $0.rawValue}, icons: [])
    
    var colors: [UIColor] = [.red, .blue, .green, .yellow, .purple, .orange, .cyan, .magenta, .brown, .gray, .lightGray, .darkGray, .lightText, .darkText, .label, .secondaryLabel, .tertiaryLabel, .quaternaryLabel]
    var searchVC = SearchVC()
    var fullScreenTransitionManager: FullScreenTransitionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        collectionView.register(ManCell.self, forCellWithReuseIdentifier: ManCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        configure()
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.tabBarController?.tabBar.isTranslucent = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.titleView?.layoutIfNeeded()
        enableHero()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableHero()
    }
    
    private func configure() {
        setupNavigationBar()
        configureCategoryButtons()
        setupCollectionView()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        let homeTitleView = HomeSearchBar(frame: view.frame)
        homeTitleView.searchBarDelegate = self
        navigationItem.titleView = homeTitleView
    }
    
    func configureCategoryButtons() {
        categoryController.delegate = self
        
        categoryController.collectionView.selectItem(at: [0,1], animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func setupCollectionView() {
        
        collectionView.register(ManCell.self, forCellWithReuseIdentifier: ManCell.identifier)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupLayout() {
        let categoryView = categoryController.view!
        
        view.addSubview(categoryView)
        view.addSubview(collectionView)
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        categoryController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        categoryController.collectionView.allowsMultipleSelection = false
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        let xOffset = CGFloat(indexPath.item) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    func didSelectProduct(product: Product, image: UIImageView) {
        let vc = ProductDetailViewController(product:product, image: image.image ?? UIImage())
        vc.imageView.heroID = "image"
        
        image.heroID = "image"
        
        navigationController?.hero.isEnabled = true
        navigationController?.heroNavigationAnimationType = .pageIn(direction: .up)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension HomeVC: HomeSearchBarDelegate {
    func tapCancelButton() {
        searchVC.view.removeFromSuperview()
    }
    
    func navigate() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.searchVC.view.isHidden{
                //                self.searchVC.view.isHidden = false
            } else {
                self.view.addSubview(self.searchVC.view)
            }
        }, completion: nil)
    }
    
    fileprivate func saveQueryUserDefaults(_ query: String?) {
        var arr: [String] = []
        if let savedQueries = UserDefaults.standard.stringArray(forKey: "savedSearchQueries") {
            arr = savedQueries
        }
        
        if !arr.contains(query ?? "") {
            arr.append(query ?? "")
        }
        
        UserDefaults.standard.set(arr, forKey: "savedSearchQueries")
    }
    
    func didTapReturn(query: String?) {
        saveQueryUserDefaults(query)
        
        let vc = SearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), query: query ?? "")
        
        
        navigationController?.pushViewController(vc, animated: true)
        
        searchVC.view.isHidden = true
    }
    
    func showTableView() {
        
    }
}

extension HomeVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManCell.identifier, for: indexPath) as! ManCell
            cell.delegate = self
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManCell.identifier, for: indexPath) as! ManCell
            cell.delegate = self
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = colors[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.frame.height)
    }
}


struct ProductViewController_Previews: PreviewProvider {
  static var previews: some View {
    ViewControllerPreview {
        TabBarViewController()
    }
  }
}
