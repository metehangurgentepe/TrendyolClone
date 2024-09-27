//
//  NetworkError.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 21.09.2024.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case unknownStatusCode(Int)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return LocaleKeys.Error.badRequest.rawValue.locale()
            case .unauthorized:
                return LocaleKeys.Error.unauthorized.rawValue.locale()
            case .forbidden:
                return LocaleKeys.Error.forbidden.rawValue.locale()
            case .notFound:
                return LocaleKeys.Error.notFound.rawValue.locale()
            case .serverError(let errorMessage):
                return LocaleKeys.Error.serverError.rawValue.locale()
            case .decodingError:
                return LocaleKeys.Error.decodingError.rawValue.locale()
            case .invalidResponse:
                return LocaleKeys.Error.invalidResponse.rawValue.locale()
            case .unknownStatusCode(let statusCode):
                return LocaleKeys.Error.unknownError.rawValue.locale()
        }
    }
}
