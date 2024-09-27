//
//  SortingBottomSheetVC.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 27.09.2024.
//

import Foundation
import UIKit

protocol SortingBottomSheetDelegate: AnyObject {
    func didSelectSorting(_ cell: String)
}

class SortingBottomSheetVC: BottomSheetViewController {
    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var delegate: SortingBottomSheetDelegate?
    
    // MARK: - Init and setup
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        self.setContent(content: tableView)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension SortingBottomSheetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortingOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = SortingOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        cell.textLabel?.textColor = cell.isSelected ? ThemeColor.primary : .label
        cell.imageView?.image = cell.isSelected ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        cell.imageView?.tintColor = ThemeColor.primary
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = SortingOptions.allCases[indexPath.row].rawValue
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectSorting(cell)
        dismissBottomSheet()
    }
}

// MARK: - Sorting Options
enum SortingOptions: String, CaseIterable {
    case highestPrice = "Highest Price"
    case lowestPrice = "Lowest Price"
    case mostPopular = "Most Popular"
    case newest = "Newest"
}

