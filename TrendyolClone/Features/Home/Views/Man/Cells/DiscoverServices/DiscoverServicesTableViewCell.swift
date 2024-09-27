//
//  ManTableViewCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import UIKit

class DiscoverServicesTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let identifier = "DiscoverServicesTableViewCell"
    let services: [Services] = DiscoverServices.allCases.map { $0.service }
    var colors: [UIColor] = [.green, .orange, .systemGray, .systemOrange, .clear, .yellow, .clear, .brown, .clear, .clear, .clear, .green]

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        collectionView.register(DiscoverServicesCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverServicesCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ThemeColor.bgColor
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        collectionView.collectionViewLayout = layout
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DiscoverServicesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverServicesCollectionViewCell.identifier, for: indexPath) as! DiscoverServicesCollectionViewCell
        let color = colors[indexPath.item]
        cell.configure(service: services[indexPath.item], color: color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 90, height: 120)
    }
}
