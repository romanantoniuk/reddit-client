//
//  NetworkLayer.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

class NetworkLayer {
    
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T>) -> ()) {
        guard let url = endpoint.url else {
            completion(.failure(HTTPNetworkError.missingURL))
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(HTTPNetworkError.init(error: error as NSError)))
            }
            if let response = response as? HTTPURLResponse, let data = data {
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                switch result {
                case .success:
                    if let dataDecoded = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(dataDecoded))
                    } else {
                        completion(.failure(HTTPNetworkError.decodingFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
}
