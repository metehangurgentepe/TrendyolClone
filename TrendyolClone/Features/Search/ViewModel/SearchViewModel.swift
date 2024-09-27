//
//  SearchViewModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 24.09.2024.
//

import Foundation

protocol SearchViewDelegate: AnyObject {
    func getProducts(products: [Product])
    func loading(_ isLoading: Bool)
    func showError(_ error: Error)
    func refreshCollectionView(product: [Product])
}

class SearchViewModel {
    let httpClient: HTTPClient
    
    weak var delegate: SearchViewDelegate?
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    private(set) var products: [Product] = []
    private(set) var searchedProducts: [Product] = []
    
    func getProducts() async{
        let url = URL(string: URLConstants.baseURL)!
        let resource  = Resource(url: url, path: .getAllProducts, modelType: ProductResponse.self)
        
        do{
            let products = try await httpClient.load(resource)
            self.products = products.products
            self.delegate?.getProducts(products: products.products)
            self.delegate?.loading(false)
        } catch {
            self.delegate?.showError(error)
        }
    }
    
    func search(query: String?) async{
//        self.delegate?.isLoading(true)
        var queryItems: [URLQueryItem] = []
        
        if let query = query {
            queryItems = [
                URLQueryItem(name: "q", value: query),
            ]
        }
        
        let url = URL(string: URLConstants.baseURL)!
        let resource  = Resource(url: url, path:.searchProducts , method: .get(queryItems), modelType: ProductResponse.self)
        
        do{
            let products = try await httpClient.load(resource)
            self.searchedProducts = products.products
            self.delegate?.refreshCollectionView(product: self.searchedProducts)
//            self.delegate?.isLoading(false)
        } catch {
            self.delegate?.showError(error)
//            self.delegate?.isLoading(false)
        }
    }
}
