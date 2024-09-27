//
//  SearchVC.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

class SearchVC: UIViewController, PastSearchesCellDelegate, UICollectionViewDelegateFlowLayout {
    
    enum Section: CaseIterable {
        case pastSearches
        case forYouProducts
        case previouslyViewedProducts
        case secondHandPopular
        
        var title: String? {
            switch self {
            case .pastSearches: return "Geçmişte Aradıklarım"
            case .forYouProducts: return "Sana Özel Ürünler"
            case .previouslyViewedProducts: return "Önceden Görüntülediklerim"
            case .secondHandPopular: return "İkinci El Popüler"
            }
        }
        
        var buttonTitle: String? {
            switch self {
            case .pastSearches: return "Temizle"
            case .forYouProducts: return "Tümünü Gör"
            case .previouslyViewedProducts: return "Tümünü Gör"
            case .secondHandPopular: return nil
            }
        }
        
        var color: UIColor? {
            switch self {
            case .pastSearches: return .gray
            case .forYouProducts: return .gray
            case .previouslyViewedProducts: return .gray
            case .secondHandPopular: return .gray
            }
        }
        
        var buttonColor: UIColor? {
            switch self {
            case .pastSearches: return .gray
            case .forYouProducts: return ThemeColor.primary
            case .previouslyViewedProducts: return ThemeColor.primary
            case .secondHandPopular: return nil
            }
        }
    }
    
    let viewModel = SearchViewModel(httpClient: HTTPClient(session: .shared))
    let tableView = UITableView(frame: .zero, style: .grouped)
    var forYouProducts: [Product] = []
    
    var pastSearch: [String] = []
    var sections: [Section] = Section.allCases
    
    override func viewDidLoad() {
        pastSearch = UserDefaults.standard.stringArray(forKey: "savedSearchQueries") ?? []
        
        configure()
        
        viewModel.delegate = self
        Task{
            await viewModel.getProducts()
        }
    }
    
    private func configure() {
        configureTableView()
    }
    
    
    func searchButtonPressed(query: String) {
        let vc = SearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), query: query ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureTableView() {
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(PastSearchesCell.self, forCellReuseIdentifier: PastSearchesCell.identifier)
        tableView.register(VerticalPhotoTableViewCell.self, forCellReuseIdentifier: VerticalPhotoTableViewCell.identifier)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.backgroundColor = ThemeColor.bgColor
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func search(query: String?) {
        let vc = SearchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), query: query ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: SearchViewDelegate {
    func getProducts(products: [Product]) {
        DispatchQueue.main.async {
            self.forYouProducts = products
            self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            self.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
        }
    }
    
    func refreshCollectionView(product: [Product]) {
        DispatchQueue.main.async{ [weak self] in
            guard let self = self else { return }
            
//            self.collectionView.reloadData()
        }
    }
    
    func loading(_ isLoading: Bool) {
        
    }
    
    func showError(_ error: any Error) {
        
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pastSearch.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 30
        case 2:
            return 95
        case 3:
            return 40
        default:
            return 120
        }
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CGFloat(pastSearch.count * 20)
        default:
            return 120
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return pastSearch.isEmpty ? 0 : 30
        default:
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PastSearchesCell.identifier, for: indexPath) as! PastSearchesCell
            cell.configure(query: pastSearch[indexPath.row])
            cell.delegate = self
            cell.tag = indexPath.row
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.set(products: forYouProducts, isFlashSale: false, willCategoryShow: false, smaller: true)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: VerticalPhotoTableViewCell.identifier, for: indexPath) as! VerticalPhotoTableViewCell
            cell.configure(product: forYouProducts)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let buttonColor = Section.allCases[section].buttonColor
        let titleColor = Section.allCases[section].color
        let title = Section.allCases[section].title!
        let buttonTitle = Section.allCases[section].buttonTitle
        return Header(title: title, seeAllButtonTitle: buttonTitle, titleColor: titleColor, buttonColor: buttonColor)
    }
    
    func didTapXButton(for cell: PastSearchesCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            if pastSearch.isEmpty {
                self.sections.remove(at: 0)
                tableView.deleteSections(IndexSet(integer: 0), with: .top)
            } else {
                self.pastSearch.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
            }
        }
    }
}
