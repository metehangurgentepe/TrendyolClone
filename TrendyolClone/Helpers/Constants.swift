//
//  Constants.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 22.09.2024.
//

import Foundation
import UIKit


enum Categories: String, CaseIterable {
    case category = "Kategoriler"
    case erkek = "Erkek"
    case kadın = "Kadın"
    case sporAndOutdoor = "Spor&Outdoor"
    case fashion = "Moda"
    case car = "Oto & Yapı Market"
    case home = "Ev & Yaşam"
    case supermarket = "Supermarket"
    case momAndBaby = "Anne & Çocuk"
    case cozmetic = "Kozmetik"
    case shoesAndBag = "Ayakkabı & Çanta"
    case electronics = "Elektronik"
    case watchAndAccessories = "Saat & Aksesuar"
    case luxury = "Lüks"
    case dolap =  "Dolap"
    case booksAndMagazines = "Kitap & Kırtasiye"
    case hobbyAndMusic = "Hobi & Müzik"
    case forWork = "İş Yerine Özel"
}

enum SearchCategories: String, CaseIterable {
    case sort = "Sırala"
    case filter = "Filtrele"
    case category = "Kategori"
    case memory = "Marka"
    case price = "Fiyat"
    case color = "Renk"
    case couponProducts = "Kuponlu Ürünler"
    case flashProducts = "Flaş Ürünler"
    
    var icon: UIImage? {
            switch self {
            case .sort:
                return UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(ThemeColor.primary)
            case .filter:
                return UIImage(systemName: "line.horizontal.3.decrease.circle")?.withTintColor(ThemeColor.primary)
            case .category:
                return UIImage(systemName: "chevron.down")?.withTintColor(ThemeColor.primary)
            case .memory:
                return UIImage(systemName: "chevron.down")?.withTintColor(ThemeColor.primary)
            case .price:
                return UIImage(systemName: "chevron.down")?.withTintColor(ThemeColor.primary)
            case .color:
                return UIImage(systemName: "chevron.down")?.withTintColor(ThemeColor.primary)
            case .couponProducts:
                return UIImage(systemName: "ticket")?.withTintColor(ThemeColor.primary)
            case .flashProducts:
                return UIImage(systemName: "bolt.fill")?.withTintColor(ThemeColor.primary)
            }
        }
}

enum DiscoverServices: CaseIterable {
    case fastMarket
    case food
    case nowSelling
    case liveStreams
    case trendyolPozitifEki
    case coupons
    case footballLove
    case financialSolutions
    case creditCard
    case categories
    case spesificCoupon
    
    var service: Services {
        switch self {
        case .fastMarket:
            return Services(image: UIImage(named: "basket")!, title: "Hızlı Market", campaignTitle: "30 DK!")
            
        case .food:
            return Services(image: UIImage(named: "hamburger")!, title: "Yemek", campaignTitle: "81 İLDE!")
            
        case .nowSelling:
            return Services(image: UIImage(named: "iphone")!, title: "Şimdi Satışta", campaignTitle: "APPLE")

        case .liveStreams:
            return Services(image: UIImage(named: "live")!, title: "Canlı Yayınlar", campaignTitle: "İndirim Kodu")

        case .trendyolPozitifEki:
            return Services(image: UIImage(named: "pozitifetki")!, title: "Trendyol Pozitif Etki", campaignTitle: "")

        case .coupons:
            return Services(image: UIImage(named: "coupon")!, title: "Kuponlar", campaignTitle: "Bugüne Özel")

        case .footballLove:
            return Services(image: UIImage(named: "football_love")!, title: "Futbol Aşkı", campaignTitle: "")

        case .financialSolutions:
            return Services(image: UIImage(named: "wallet")!, title: "Finansal Çözümler", campaignTitle: "0 Faiz Fırsatı")

        case .creditCard:
            return Services(image: UIImage(named: "credit_card")!, title: "Kredi Kartı", campaignTitle: "")

        case .categories:
            return Services(image: UIImage(named: "category")!, title: "Kategoriler", campaignTitle: "")

        case .spesificCoupon:
            return Services(image: UIImage(named: "t_shirt")!, title: "120 TL Kupon", campaignTitle: "DOLAP")

        }
    }
}

enum SliderImages{
    static let images: [String] = ["slider1", "slider2", "slider3", "slider4"]
}
