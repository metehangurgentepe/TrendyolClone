//
//  ImageCell.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit
import Kingfisher

protocol ImageCellDelegate: AnyObject {
    func changeBackgroundColor(_ color: UIColor)
}

class ImageCell: UICollectionViewCell, ImageCellDelegate {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var delegate: ImageCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeBackgroundColor(_ color: UIColor) {
        imageView.backgroundColor = backgroundColor
    }

    func configure(imageUrl: String, isFromInternet: Bool) {
        if isFromInternet {
            imageView.kf.setImage(with: URL(string: imageUrl))
        } else {
            imageView.image = UIImage(named: imageUrl)
        }
    }
}
