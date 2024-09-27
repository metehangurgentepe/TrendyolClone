//
//  LocaleKeys.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation

extension String{
    func locale() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

struct LocaleKeys {
    enum Home: String{
        case weeknighFav = "home_weeknight_fav"
        case communitySection = "home_community"
        case trending = "home_trending"
        case popular = "home_popular"
        case shuffledAppetizers = "home_shuffled_appetizers"
        case recents = "home_recents"
    }
    
    enum TabBar: String {
        case discover = "tab_bar_discover"
        case profile = "tab_bar_profile"
        case community = "tab_bar_community"
        case mealPlans = "tab_bar_meal_plans"
    }
    
    enum Error: String{
        case badRequest = "error_bad_request"
        case unauthorized = "error_unauthorized"
        case forbidden = "error_forbidden"
        case notFound = "error_not_found"
        case serverError = "error_server_error"
        case decodingError = "error_decoding_error"
        case invalidResponse = "error_invalid_response"
        case unknownError = "error_unknown_error"
        case error = "error_message"
        case ok = "error_ok"
    }
}
