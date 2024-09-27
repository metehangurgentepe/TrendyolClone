//
//  ImageSliderView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

class ImageSliderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let images: [String]
    private let collectionView: UICollectionView
    
    private var currentIndex: Int = 0
    private var timer: Timer?

    init(images: [String]) {
        self.images = images
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        super.init(frame: .zero)
        setupCollectionView()
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    @objc private func nextImage() {
        currentIndex += 1
        if currentIndex >= images.count {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating scrollView: UIScrollView) {
        let pageIndex = Int(collectionView.contentOffset.x / collectionView.frame.width)
        currentIndex = pageIndex
    }
    
    deinit {
        timer?.invalidate()
    }

    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(imageUrl: images[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionView DelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}
