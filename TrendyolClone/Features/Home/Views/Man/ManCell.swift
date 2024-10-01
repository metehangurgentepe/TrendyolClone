//
//  ManCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit


protocol HomeCellDelegate: AnyObject {
    func didSelectProduct(product: Product, image: UIImageView)
}

class ManCell: UICollectionViewCell, ProductCellDelegate {
    static let identifier: String = "ManCell"
    
    let viewModel = HomeViewModel(httpClient: HTTPClient(session: .shared))
    var slider = ImageSliderView(images: SliderImages.images, isFromInternet: false, showPageControl: false)
    
    var delegate: HomeCellDelegate?
    
    enum Section: CaseIterable{
        case discoverServices
        case forYou
        case flashProducts
        case popularCampaigns
        case interesetedProducts
        
        var title: String {
            switch self {
            case .discoverServices: return "Hizmetlerimizi Keşfet"
            case .forYou: return "Sana Özel Ürünler"
            case .flashProducts: return "Flaş Ürünler"
            case .popularCampaigns: return "Popüler Kampanyalar"
            case .interesetedProducts: return "İlgilendiklerine Özel"
            }
        }
        
        var buttonTitle: String? {
            switch self {
            case .discoverServices: return "Tümü"
            case .forYou: return "Tüm Ürünler"
            case .flashProducts: return "Tümünü Gör"
            case .popularCampaigns: return nil
            case .interesetedProducts: return "Tümünü Gör"
            }
        }
        
        var color: UIColor? {
            switch self {
            case .discoverServices: return .gray
            case .forYou: return .gray
            case .flashProducts: return .white
            case .popularCampaigns: return .gray
            case .interesetedProducts: return .gray
            }
        }
        
        var buttonColor: UIColor? {
            switch self {
            case .discoverServices: return nil
            case .forYou: return ThemeColor.primary
            case .flashProducts: return .white
            case .popularCampaigns: return nil
            case .interesetedProducts: return ThemeColor.primary
            }
        }
    }
    
    var forYouProducts: [Product] = []
    
    let tableView = UITableView(frame: .zero,style: .grouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewModel.delegate = self
        
        Task{
            await viewModel.getProducts()
        }
        
        tableView.tableHeaderView = slider
        
        slider.frame.size.height = 100
        tableView.tableHeaderView = slider
        
        tableView.register(DiscoverServicesTableViewCell.self, forCellReuseIdentifier: DiscoverServicesTableViewCell.identifier)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(PopularCampaignsTableViewCell.self, forCellReuseIdentifier: PopularCampaignsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor.bgColor
        tableView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(tableView)
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ManCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverServicesTableViewCell.identifier, for: indexPath) as! DiscoverServicesTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.set(products: forYouProducts, isFlashSale: false, willCategoryShow: false, smaller: false, delegate: self)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.set(products: forYouProducts, isFlashSale: true, willCategoryShow: false,smaller: false, delegate: self)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularCampaignsTableViewCell.identifier, for: indexPath) as! PopularCampaignsTableViewCell
            cell.configure(product: forYouProducts.shuffled())
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.set(products: forYouProducts, isFlashSale: false, willCategoryShow: false,smaller: false, delegate: self)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverServicesTableViewCell.identifier, for: indexPath) as! DiscoverServicesTableViewCell
            return cell
        }
    }
    
    func didSelectProduct(product: Product,image: UIImageView) {
        self.delegate?.didSelectProduct(product: product,image: image)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let buttonColor = Section.allCases[section].buttonColor
        let titleColor = Section.allCases[section].color
        let title = Section.allCases[section].title
        let buttonTitle = Section.allCases[section].buttonTitle
        return Header(title: title, seeAllButtonTitle: buttonTitle, titleColor: titleColor, buttonColor: buttonColor)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 140
        case 2:
            return 330
        case 3:
            return 250
        case 4:
            return 340
            
        default:
            return 300
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

extension ManCell: HomeViewDelegate {
    func getProducts(products: [Product]) {
        DispatchQueue.main.async {
            self.forYouProducts = products
            self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
            self.tableView.reloadSections(IndexSet(integer: 4), with: .fade)
        }
    }
    
    func showError(_ error: any Error) {
        
    }
    
    func loading(_ isLoading: Bool) {
        
    }
}
