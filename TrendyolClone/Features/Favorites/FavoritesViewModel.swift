//
//  FavoritesViewModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 2.10.2024.
//

import Foundation

protocol FavoritesViewDelegate: AnyObject {
    func getProducts(products: [Product] )
    func showError(_ error: Error)
    func loading(_ isLoading: Bool)
}

class FavoritesViewModel {
    let httpClient: HTTPClient
    
    weak var delegate: FavoritesViewDelegate?
    private(set) var products: [Product] = []
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    func getProducts() async{
        var queryItems: [URLQueryItem] =  [
            URLQueryItem(name: "limit", value: "\(10)"),
            URLQueryItem(name: "skip", value: "0")
        ]
        
        let url = URL(string: URLConstants.baseURL)!
        let resource  = Resource(url: url, path: .getAllProducts,method: .get(queryItems), modelType: ProductResponse.self)
        
        do{
            let products = try await httpClient.load(resource)
            self.products = products.products
            self.delegate?.getProducts(products: products.products)
            self.delegate?.loading(false)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
