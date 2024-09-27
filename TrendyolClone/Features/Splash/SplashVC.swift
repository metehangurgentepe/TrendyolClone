//
//  SplashVC.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation
import UIKit
import SnapKit

class SplashVC: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launch")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupUI()
    }
    
    
    func setupUI() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        let delay = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            let vc = TabBarViewController()
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        }
    }
}
