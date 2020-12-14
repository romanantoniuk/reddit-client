//
//  EndPoint.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case getTopPost(after: String?, count: Int?)
    
    private var path: String {
        switch self {
        case .getTopPost:
            return "/top.json"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getTopPost(let value):
            var items: [URLQueryItem] = [.init(name: "limit", value: "25")]
            if let after = value.after {
                items.append(.init(name: "after", value: after))
            }
            if let count = value.count, count > 0 {
                items.append(.init(name: "count", value: "\(count)"))
            }
            return items
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
