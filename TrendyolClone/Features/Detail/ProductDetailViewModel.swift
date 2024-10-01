//
//  ProductDetailViewModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 30.09.2024.
//

import Foundation

protocol ProductDetailViewDelegate: AnyObject {
    func getProducts(products: [Product] )
    func showError(_ error: Error)
    func loading(_ isLoading: Bool)
}

class ProductDetailViewModel {
    let httpClient: HTTPClient
    
    weak var delegate: ProductDetailViewDelegate?
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
    }
    
    private(set) var products: [Product] = []
    var numberOfProducts: Int = 0
    
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
    
    func skipProducts() async {
        numberOfProducts += 10
        
        var queryItems: [URLQueryItem] =  [
            URLQueryItem(name: "limit", value: "\(numberOfProducts ?? 0)"),
            URLQueryItem(name: "skip", value: "10")
        ]
        
        let url = URL(string: URLConstants.baseURL)!
        let resource  = Resource(url: url, path: .getAllProducts, method: .get(queryItems), modelType: ProductResponse.self)
        
        do{
            let products = try await httpClient.load(resource)
            self.products += products.products
            self.delegate?.getProducts(products: products.products)
            
            print(self.products.count , "number")
            self.delegate?.loading(false)
        } catch {
            self.delegate?.showError(error)
        }
    }
}
