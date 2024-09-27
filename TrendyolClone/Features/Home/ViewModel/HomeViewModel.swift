//
//  HomeViewModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func getProducts(products: [Product] )
    func showError(_ error: Error)
    func loading(_ isLoading: Bool)
}

class HomeViewModel {
    let httpClient: HTTPClient
    
    weak var delegate: HomeViewDelegate?
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    private(set) var products: [Product] = []
    
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
}
