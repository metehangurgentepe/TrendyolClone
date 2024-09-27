//
//  Product.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title, description: String
//    let category: String
    let price, discountPercentage, rating: Double
//    let stock: Int
//    let tags: [String]
    let brand: String?
    let sku: String
//    let weight: Int
    let reviews: [Review]
    let warrantyInformation, shippingInformation: String
//    let availabilityStatus: String
//    let returnPolicy: String
//    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
}

// MARK: - Review
struct Review: Codable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName, reviewerEmail: String
}
