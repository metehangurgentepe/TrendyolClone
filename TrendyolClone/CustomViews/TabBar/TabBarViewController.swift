//
//  TabBarViewController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

//
//  TabBarViewController.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 23.09.2024.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance;
        
        self.viewControllers = TabBarModel.createTabBarItems().map{ $0.viewController }
        setupTabs()
        self.tabBar.tintColor = ThemeColor.primary
        self.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = .white
        tabBar.backgroundColor = .white
        
        addTopLine()
    }
    
    private func addTopLine() {
        let topLine = CALayer()
        topLine.backgroundColor = UIColor.gray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 0.3)
        tabBar.layer.addSublayer(topLine)
    }
    
    private func setupTabs() {
        let firstVC = TabBarModel.createTabBarItems()[0]
        let secondVC = TabBarModel.createTabBarItems()[1]
        let thirdVC = TabBarModel.createTabBarItems()[2]
        let fourthVC = TabBarModel.createTabBarItems()[3]
        let fifthVC = TabBarModel.createTabBarItems()[4]
        
        let home = self.createNav(
            with: firstVC.title,
            and: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"),
            vc: firstVC.viewController)
        
        let search = self.createNav(
            with: secondVC.title,
            and: UIImage(named: "trendyol_go"),
            selectedImage: UIImage(named: "trendyol_go"),
            vc: secondVC.viewController)
        
        let saved = self.createNav(
            with: thirdVC.title,
            and: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill"),
            vc: thirdVC.viewController)
        
        let basket = self.createNav(
            with: fourthVC.title,
            and: UIImage(named: "basket_tab_bar"),
            selectedImage: UIImage(named: "basket_tab_bar"),
            vc: fourthVC.viewController)
        
        let profile = self.createNav(
            with: fifthVC.title,
            and: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"),
            vc: fifthVC.viewController)
        
        self.setViewControllers([home,search,saved,basket,profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image?.resizeImage(targetSize: CGSize(width: 22, height: 22))
        nav.tabBarItem.selectedImage = selectedImage?.resizeImage(targetSize: CGSize(width: 22, height: 22))
        return nav
    }
}
