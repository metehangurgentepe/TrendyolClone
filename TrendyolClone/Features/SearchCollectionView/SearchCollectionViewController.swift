//
//  SearchCollectionViewController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit
import BottomSheet


class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UISearchControllerDelegate, SearchControllerDelegate, SortingBottomSheetDelegate {
    let viewModel = SearchViewModel(httpClient: HTTPClient(session: .shared))
    var searchedProducts: [Product] = []
    var searchBar = SearchBarTitleView(frame: .zero)
    let categoryController = SearchCategoryController(collectionViewLayout: UICollectionViewFlowLayout(), categories: SearchCategories.allCases.map { $0.rawValue}, icons: SearchCategories.allCases.map { $0.icon ?? UIImage(systemName: "questionmark.circle")!})
    let searchVC = SearchVC()
    var selectedIndexPath: IndexPath?
    
    var overlayView: UIView!
    var categorySheetVC: CategorySheetViewController!
    
    
    var query: String?
    var delegate: HomeSearchBarDelegate?
    
    init(collectionViewLayout layout: UICollectionViewLayout, query: String) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.query = query
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryController.delegate = self
        
        setupViewController()
        
        searchBar.searchBarDelegate = self
        
        viewModel.delegate = self
        
        Task {
            await viewModel.search(query: query)
        }
        
        setupCategoryController()
        setupCollectionView()
    }
    
    func setupViewController() {
        setNeedsStatusBarAppearanceUpdate()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.view.backgroundColor = .white
        
        navigationItem.hidesBackButton = true
        
        searchBar.searchBar.text = query
        navigationItem.titleView = searchBar
    }
    
    func showCategorySheet(_ indexPath: IndexPath, title: String, categories: [String]) {
        let heightView = CGFloat(min(categories.count * 65, 200))
        if categorySheetVC == nil {
            categorySheetVC = CategorySheetViewController(categories: categories, placeholder: title)
            setupOverlayView()
            
            addChild(categorySheetVC)
            view.addSubview(categorySheetVC.view)
            
            categorySheetVC.view.translatesAutoresizingMaskIntoConstraints = false
            
            let heightConstraint = categorySheetVC.view.heightAnchor.constraint(equalToConstant: 0)
            let initialYConstraint = categorySheetVC.view.topAnchor.constraint(equalTo: categoryController.view.bottomAnchor)
            
            NSLayoutConstraint.activate([
                categorySheetVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                categorySheetVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                heightConstraint,
                initialYConstraint
            ])
            
            view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                heightConstraint.constant = heightView
                self.view.layoutIfNeeded()
            }, completion: { _ in
                heightConstraint.constant = heightView
            })
            
            categorySheetVC.didMove(toParent: self)
        } else {
            categorySheetVC.updateCategories(categories: categories, title: title)
            
            let newHeight = heightView
            
            if let heightConstraint = categorySheetVC.view.constraints.first(where: { $0.firstAttribute == .height }) {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                    guard let self = self else { return }
                    heightConstraint.constant = newHeight
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    
    
    @objc func hideCategorySheet() {
        guard let categorySheetVC = self.categorySheetVC else {
            return
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else { return }
            
            if let heightConstraint = self.categorySheetVC.view.constraints.first(where: { $0.firstAttribute == .height }) {
                heightConstraint.isActive = false
            }
            
            self.categorySheetVC.view.topAnchor.constraint(equalTo: self.categoryController.view.bottomAnchor).isActive = true
            self.categorySheetVC.view.layoutIfNeeded()
            
            self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.categorySheetVC.view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            self.categorySheetVC.applyButton.isHidden = true
            self.categorySheetVC.clearButton.isHidden = true
            self.categorySheetVC.collectionView.isHidden = true
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            categorySheetVC.willMove(toParent: nil)
            categorySheetVC.view.removeFromSuperview()
            categorySheetVC.removeFromParent()
            self.categoryController.collectionView.deselectItem(at: self.selectedIndexPath!, animated: true)
            self.categorySheetVC = nil
        })
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        let categories2 = ["All","Food"]
        let categories3 = ["Nike", "Adidas", "Puma", "Reebok", "Vans", "Under Armour","Lescon","Levis", "Other"]
        
        
        if indexPath.item == 2 {
            showCategorySheet(indexPath, title: "Kategori Ara", categories: categories2)
        } else if indexPath.item == 3 {
            showCategorySheet(indexPath, title: "Marka Ara", categories: categories3)
        } else if indexPath.item == 0 {
            presentSortOptions()
        }
    }
    
    func presentSortOptions() {
        let vc = SortingBottomSheetVC()
        vc.delegate = self
        presentBottomSheet(viewController: vc)
    }
    
    
    func deselectMenuItem(indexPath: IndexPath) {
        if indexPath.item == 2 || indexPath.item == 3{
            hideCategorySheet()
        }
    }
    
    func setupOverlayView() {
        overlayView = UIView(frame: CGRect(x: 0, y: 200, width: ScreenSize.width, height: ScreenSize.height - 200))
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0)
        view.addSubview(overlayView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideCategorySheet))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    func removeOverlayView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideCategorySheet))
        overlayView.removeFromSuperview()
        overlayView.removeGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = ThemeColor.bgColor
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryController.view.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupCategoryController() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        
        view.addSubview(bottomLine)
        
        categoryController.view.backgroundColor = .white
        
        view.addSubview(categoryController.view)
        
        categoryController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(categoryController.view.snp.bottom).offset(9)
            make.width.equalTo(ScreenSize.width)
            make.leading.equalToSuperview()
            make.height.equalTo(0.2)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchedProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.configure(product: searchedProducts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (ScreenSize.width / 2) - 10, height: ScreenSize.height / 2)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func didSelectSorting(_ cell: String) {
        print("cell: \(cell)")
        collectionView.deselectItem(at: IndexPath.init(item: 0, section: 0), animated: true)
    }
}

extension SearchCollectionViewController: SearchBarViewDelegate {
    func showCollectionView() {
        self.searchVC.view.isHidden = true
        searchBar.searchBar.text = query
    }
    
    func search(_ query: String) {
        let vc = SearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), query: query)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigate() {
        if searchVC.view.isHidden {
            searchVC.view.isHidden = false
        } else {
            UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.view.addSubview(self.searchVC.view)
                
                self.searchVC.view.snp.makeConstraints { make in
                    make.edges.equalTo(self.view)
                }
            }, completion: nil)
        }
    }
    
    func searchBarDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SearchCollectionViewController: SearchViewDelegate {
    func getProducts(products: [Product]) {
        DispatchQueue.main.async {
            
        }
    }
    
    func refreshCollectionView(product: [Product]) {
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
            self.searchedProducts = product
            self.collectionView.reloadData()
        }
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func showError(_ error: any Error) {
        
    }
}

extension SearchCollectionViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


