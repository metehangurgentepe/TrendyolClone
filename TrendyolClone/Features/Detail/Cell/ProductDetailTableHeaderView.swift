//
//  ProductDetailTableHeaderView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 1.10.2024.
//

import UIKit

class ProductDetailTableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "ProductDetailTableHeaderView"
    

    let slider = ImageSliderView(images: [], isFromInternet: true, showPageControl: true)
    
    init(reuseIdentifier: String?, images: [String]) {
        super.init(reuseIdentifier: reuseIdentifier)
        slider.images = images
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(slider)
//        let panGestures = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        
//        slider.addGestureRecognizer(panGestures)
//        slider.isUserInteractionEnabled = true
        
        slider.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        slider.frame = CGRect(x: 0, y: 0, width: frame.width, height: ScreenSize.height * 0.6)
    }
    
    
    
}
