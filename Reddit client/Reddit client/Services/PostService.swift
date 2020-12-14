//
//  PostService.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

final class PostService {
    
    static var shared = PostService()
    
    private init() {}
    
    func getTopPosts(after: String?, count: Int, completion: @escaping (_ items: [DataPost], _ error: String?) -> ()) {
        NetworkLayer.request(endpoint: .getTopPost(after: after, count: count)) { (result: Result<RespondTopPost>) in
            switch result {
            case .success(let response):
                completion(response.data.children.map({$0.data}), nil)
            case .failure(let error):
                completion([], error.desc)
            }
        }
    }
    
}
