//
//  ProductDetailVC.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 28.09.2024.
//

import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    
    enum Section: CaseIterable {
        case brand
        case productReviews
        case similarProducts
        case moreSuggestions
    }
    
    let imageView = UIImageView()
    let viewModel = ProductDetailViewModel(httpClient: HTTPClient(session: .shared))
    
    var product: Product?
    var homeSearchBar = ProductDetailSearchBarTitleView(frame: .zero)
    private var initialPanPosition: CGPoint = .zero
    let likeButton = LikeButton(frame: .zero)
    var products: [Product] = []
    
    let tableView = UITableView()
    var isLoading = false
    
    init(product: Product,image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupSlider()
        setupBottomBar()
        setupLikeButton()
        
        viewModel.delegate = self
        
        Task{await viewModel.getProducts()}
    }
    
    func statusBarWhite() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(view.safeAreaInsets.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        statusBarWhite()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = ThemeColor.bgColor
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        
        tableView.register(ProductTitleView.self, forCellReuseIdentifier: ProductTitleView.identifier)
        tableView.register(ProductReviewCell.self, forCellReuseIdentifier: ProductReviewCell.identifier)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(InfiniteScrollsVerticalTableViewCell.self, forCellReuseIdentifier: InfiniteScrollsVerticalTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func imageFade() {
        let offsetY = tableView.contentOffset.y + 44
        let maxOffset: CGFloat = ScreenSize.height * 0.6
        
        let alpha = min(offsetY / maxOffset, 1)
        
        UIView.animate(withDuration: 0.02) {
//            self.slider.backgroundColor = UIColor.black.withAlphaComponent(alpha)
//            self.slider.alpha = 1 - alpha
            self.tableView.tableHeaderView?.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            self.tableView.tableHeaderView?.alpha = 1 - alpha
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageFade()
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 200 && !isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            await viewModel.skipProducts()
            isLoading = false
            tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
        }
    }
    
    
    private func setupBottomBar() {
        let height = self.tabBarController?.tabBar.frame.size.height ?? 100
        
        let priceLabel = UILabel()
        priceLabel.text = "\(product?.price ?? 0) TL"
        priceLabel.font = .preferredFont(forTextStyle: .headline)
        priceLabel.textColor = ThemeColor.primary
        
        let freeShippingLabel = UILabel()
        freeShippingLabel.text = "Kargo Bedava"
        freeShippingLabel.font = .preferredFont(forTextStyle: .caption1)
        freeShippingLabel.textColor = .green
        
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel, freeShippingLabel])
        priceStackView.axis = .vertical
        priceStackView.backgroundColor = .white
        priceStackView.spacing = 5
        priceStackView.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 0)
        priceStackView.isLayoutMarginsRelativeArrangement = true
        
        let buyNow = DefaultButton(frame: .zero, title: "Şimdi Al", titleColor: ThemeColor.primary, backgroundColor: .white, borderWidth: 0.5)
        
        let addBasket = DefaultButton(frame: .zero, title: "Sepete Ekle", titleColor: .white, backgroundColor: ThemeColor.primary, borderWidth: 0)
        
        let stackView = UIStackView(arrangedSubviews: [priceStackView, buyNow, addBasket])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        buyNow.snp.makeConstraints { make in
            make.width.equalTo(ScreenSize.width * 0.4)
            make.height.equalTo(40)
        }
        
        addBasket.snp.makeConstraints { make in
            make.width.equalTo(ScreenSize.width * 0.4)
            make.height.equalTo(40)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.width.equalTo(ScreenSize.width * 0.2)
            make.height.equalTo(50)
        }
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height + 10)
        }
        
        let topLine = UIView()
        topLine.backgroundColor = .lightGray
        topLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        view.addSubview(topLine)
        
        topLine.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setupLikeButton() {
        view.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }
    }
    
    fileprivate func setupSlider() {
        let slider = ImageSliderView(images: product?.images ?? [], isFromInternet: true , showPageControl: true)
    
        slider.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ScreenSize.height * 0.6)
        tableView.tableHeaderView = slider
        
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
                
        navigationItem.titleView = homeSearchBar
        homeSearchBar.searchBarDelegate = self
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if gesture.state == .began {
            initialPanPosition = gesture.location(in: view)
        } else if gesture.state == .changed {
            if translation.y > 0 {
//                slider.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        } else if gesture.state == .ended {
            if translation.y > 100 {
                self.navigationController?.popViewController(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
//                    self.slider.transform = .identity
                }
            }
        }
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 40
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            return Header(title: "Benzer Ürünler", seeAllButtonTitle: "", titleColor: .gray, buttonColor: nil)
        default:
            let headerView = UIView()
            headerView.backgroundColor = .white
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
            
        case 1:
            return 230
            
        case 3:
            let numberOfItems = self.products.count
            let itemsPerRow: CGFloat = 2
            let rows = ceil(CGFloat(numberOfItems) / itemsPerRow)
            
            let itemHeight: CGFloat = ScreenSize.height / 2
            let totalHeight = max(rows * itemHeight, 50)
            return totalHeight
            
        default:
            return 300
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTitleView.identifier, for: indexPath) as! ProductTitleView
            cell.set(title: product?.brand ?? "", model: product?.title ?? "", rating: product?.rating ?? 0, price: product?.price ?? 0)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductReviewCell.identifier, for: indexPath)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.set(products: products, isFlashSale: false, willCategoryShow: false, smaller: false, delegate: nil)
            cell.collectionView.backgroundColor = .white
            cell.backgroundColor = .white
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfiniteScrollsVerticalTableViewCell.identifier, for: indexPath) as! InfiniteScrollsVerticalTableViewCell
            cell.configure(products: self.products)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
}

extension ProductDetailViewController: ProductDetailSearchBarTitleViewDelegate {
    func searchBarDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigate() {
        
    }
    
    func search(_ query: String) {
        
    }
    
    func showCollectionView() {
        
    }
    
    
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func getProducts(products: [Product]) {
        DispatchQueue.main.async{
            self.products = products
            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            //            self.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
        }
    }
    
    func showError(_ error: any Error) {
        
    }
    
    func loading(_ isLoading: Bool) {
        
    }
}



struct ProductDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            TabBarViewController()
        }
    }
}
