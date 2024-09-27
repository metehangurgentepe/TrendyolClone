//
//  RatingView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 25.09.2024.
//

import UIKit

class RatingView: UIStackView {
    
    // UI bileşenleri
    private let ratingLabel = UILabel()        // Puan gösterimi
    private let starsStackView = UIStackView() // Yıldızlar için StackView
    private let reviewCountLabel = UILabel()   // Yorum sayısı
    
    var rating: Double = 0.0 {
        didSet {
            updateRating() // Puan güncellendiğinde yıldızları da güncelle
        }
    }
    
    var reviewCount: Int = 0 {
        didSet {
            updateReviewCount() // Yorum sayısı güncellendiğinde label'ı güncelle
        }
    }
    
    private let maxRating = 5   // Maksimum yıldız sayısı
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Rating label yapılandırması
        ratingLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        ratingLabel.textColor = .black
        addArrangedSubview(ratingLabel)
        
        // Yıldızlar StackView yapılandırması
        starsStackView.axis = .horizontal
        starsStackView.spacing = 4
        addArrangedSubview(starsStackView)
        
        // Yorum sayısı label yapılandırması
        reviewCountLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        reviewCountLabel.textColor = .gray
        addArrangedSubview(reviewCountLabel)
        
        // Arka plan ve aralık ayarları
        axis = .horizontal
        spacing = 2
        alignment = .leading
        distribution = .equalSpacing
    }
    
    private func updateRating() {
        // Puanı label'a yazdır
        ratingLabel.text = String(format: "%.1f", rating)
        
        // Yıldızları temizle ve yeniden ekle
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Dolu ve boş yıldızları hesapla
        let fullStars = Int(rating)
        let halfStar = rating - Double(fullStars) >= 0.5
        let emptyStars = maxRating - fullStars - (halfStar ? 1 : 0)
        
        // Dolu yıldızları ekle
        for _ in 0..<fullStars {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = ThemeColor.starColor
            starImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
            starsStackView.addArrangedSubview(starImageView)
        }
        
        // Yarım yıldız varsa ekle
        if halfStar {
            let halfStarImageView = UIImageView(image: UIImage(systemName: "star.lefthalf.fill"))
            halfStarImageView.tintColor = ThemeColor.starColor
            halfStarImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
            starsStackView.addArrangedSubview(halfStarImageView)
        }
        
        // Boş yıldızları ekle
        for _ in 0..<emptyStars {
            let emptyStarImageView = UIImageView(image: UIImage(systemName: "star"))
            emptyStarImageView.tintColor = ThemeColor.starColor
            emptyStarImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
            starsStackView.addArrangedSubview(emptyStarImageView)
        }
        
        starsStackView.spacing = 1
        starsStackView.distribution = .equalSpacing
    }
    
    private func updateReviewCount() {
        // Yorum sayısını güncelle
        reviewCountLabel.text = "(\(reviewCount))"
    }
}
