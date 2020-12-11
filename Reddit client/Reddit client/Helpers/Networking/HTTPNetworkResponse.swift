//
//  HTTPNetworkResponse.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

struct HTTPNetworkResponse {
    
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String>{
        guard let response = response else { return Result.failure(HTTPNetworkError.unwrappingError)}
        switch response.statusCode {
        case 200...299:
            return .success(HTTPNetworkError.success.desc)
        case 401:
            return .failure(HTTPNetworkError.authenticationError)
        case 400...499:
            return .failure(HTTPNetworkError.badRequest)
        case 500...599:
            return .failure(HTTPNetworkError.serverSideError)
        default:
            return .failure(HTTPNetworkError.failed)
        }
    }
    
}
