//
//  EndPoint.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getTopPost
    
    private var path: String {
        switch self {
        case .getTopPost:
            return "/top.json"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getTopPost:
            return []
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTopPost:
            return .get
        }
    }
    
    var url: URL? {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = Constants.apiUrl
            components.path = self.path
            components.queryItems = self.queryItems
            return components.url
        }
    }
    
}
