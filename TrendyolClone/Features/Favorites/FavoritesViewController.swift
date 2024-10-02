//
//  FavoritesViewController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import UIKit

class FavoritesViewController: UICollectionViewController {
    
    let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    let viewModel = FavoritesViewModel(httpClient: .init(session: .shared))
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        Task{
            await viewModel.getProducts()
        }
        
        navigationController?.navigationBar.removeFromSuperview()
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "second")
        
        setupMenu()
        setupLayout()
    }
    
    private func setupMenu() {
        menuController.delegate = self
        menuController.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 2
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        menuController.collectionView.allowsMultipleSelection = false
    }
    
    func setupLayout() {
        
        let menuView = menuController.view!
        
        view.addSubview(menuView)
        view.addSubview(collectionView)
        
        menuView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(menuController.view.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension FavoritesViewController: FavoriteMenuControllerDelegate, UICollectionViewDelegateFlowLayout {
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
            cell.configure(products: products)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
//            cell.configure(products: products)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
    
    
}

extension FavoritesViewController: FavoritesViewDelegate {
    func getProducts(products: [Product]) {
        DispatchQueue.main.async {
            self.products = products
            self.collectionView.reloadItems(at: [IndexPath(index: 0)])
        }
    }
    
    func showError(_ error: any Error) {
        
    }
    
    func loading(_ isLoading: Bool) {
        
    }
}
