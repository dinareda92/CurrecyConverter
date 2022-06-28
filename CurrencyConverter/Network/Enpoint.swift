//
//  Endpoint.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/22/22.
//

import Foundation
import Moya
protocol Endpoint {
    
    var httpMethod: HttpMethod { get }
    var body: Data? { get }
    var baseUrl: String { get }
    var path: String { get }
    var url: URL? { get }
    var headers: String { get}
}

extension Endpoint {
    var httpMethod: HttpMethod {
        .post
    }
    var url: URL? {
        URL(string:  baseUrl + path)
    }
    
    var body: Data? {
        nil
    }
    
    var baseUrl: String {
        AppConstants.baseUrl
    }
    
    var headers: String {
        AppConstants.apiKey
    }
}

struct AppConstants {
    static let baseUrl = "https://api.apilayer.com/fixer/"
    static let apiKey = "eHj8OzHn5Fqypoi31HGMpTX6nxYJmGvV"
}

enum HttpMethod {
    case post
    case get
}

enum CurrencyAPI: Endpoint {
    
    case latest
    var path: String {
        switch self {
        case .latest:
            return "latest"
        }
    }
        
}
