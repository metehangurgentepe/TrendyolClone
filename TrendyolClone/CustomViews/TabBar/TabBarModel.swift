//
//  TabBarModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

struct TabBarModel {
    let iconName: String
    let title: String
    let viewController: UIViewController
    
    var icon: UIImage? {
        return UIImage(named: iconName)
    }
    
    static func createTabBarItems() -> [TabBarModel] {
        let firstTab = TabBarModel(iconName: "",
                                   title: "Anasayfa",
                                   viewController: HomeVC(collectionViewLayout: UICollectionViewFlowLayout()))
        let secondTab = TabBarModel(iconName: "", title: "Trendyol Go", viewController: UIViewController())
        let thirdTab = TabBarModel(iconName: "", title: "Favorilerim", viewController: FavoritesViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let fourthTab = TabBarModel(iconName: "", title: "Sepetim", viewController: UIViewController())
        let fifthTab = TabBarModel(iconName: "", title: "Hesabım", viewController: UIViewController())
        
        
        return [firstTab, secondTab, thirdTab, fourthTab, fifthTab]
    }
}
