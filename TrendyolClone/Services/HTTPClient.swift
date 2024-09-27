//
//  HTTPClient.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation


import Foundation

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
            case .put:
                return "PUT"
        }
    }
}

enum URLPath {
    case getAllProducts
    case searchProducts
    case detailProduct(String)
    
    var name: String {
        switch self {
        case .getAllProducts:
            "/products"
        case .detailProduct(let id):
            "/products/\(id)"
        case .searchProducts:
            "/products/search"
        }
    }
}


struct Resource<T: Codable> {
    let url: URL
    var path: URLPath
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
    var modelType: T.Type
}


struct HTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.session = session
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        // Set HTTP method and body if needed
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            
            components?.path.append(resource.path.name)
            components?.queryItems = queryItems
            
            print(components?.url, "URL BURADA")
            
            guard let url = components?.url else {
                throw NetworkError.badRequest
            }
            request.url = url
            
        case .post(let data), .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
            
        case .delete:
            request.httpMethod = resource.method.name
        }
        
        // Set custom headers
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        print(data)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
        case 200...299:
            break // Success
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.unknownStatusCode(httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
