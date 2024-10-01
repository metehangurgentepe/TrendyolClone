//
//  ImageSliderView.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

import UIKit

class ImageSliderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var images: [String] {
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = images.count > 3 ? 3 : images.count
            pageControlView.snp.updateConstraints { make in
                make.width.equalTo(images.count * 25)
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet{
            collectionView.backgroundColor = backgroundColor
            
            delegate?.changeBackgroundColor(backgroundColor ?? .clear)
        }
    }
    
    private let collectionView: UICollectionView
    private var currentIndex: Int = 0
    private var timer: Timer?
    var isFromInternet: Bool? = false
    private var pageControl = UIPageControl()
    let pageControlView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        return view
    }()
    
    weak var delegate: ImageCellDelegate?
    
    init(images: [String], isFromInternet: Bool, showPageControl: Bool) {
        self.images = images
        self.isFromInternet = isFromInternet
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        
        super.init(frame: .zero)
        setupCollectionView()
        if showPageControl {
            setupPageControl()
        }
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
    
    private func setupPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        
        addSubview(pageControlView)
        pageControlView.addSubview(pageControl)
        
        pageControlView.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(images.count * 30)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func startTimer() {
        if !(isFromInternet ?? false) {
//            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func nextImage() {
        currentIndex += 1
        if currentIndex >= images.count {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex  // Page control güncelleniyor
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard scrollView.frame.width > 0 else { return }
        
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = pageIndex
        pageControl.currentPage = currentIndex
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
        cell.configure(imageUrl: images[indexPath.item], isFromInternet: isFromInternet ?? false)
        return cell
    }
    
    // MARK: - UICollectionView DelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}
