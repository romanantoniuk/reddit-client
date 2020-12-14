//
//  DataPost.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

struct DataPost: Codable {
    
    var author: String?
    var commentsCount: Int?
    var datePublish: Int64
    var postHint: String
    var name: String
    var originalFileUrl: String?
    var thumbnailHeight: Int?
    var thumbnailUrl: String?
    var thumbnailWidth: Int?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case author
        case title
        case datePublish = "created"
        case thumbnailUrl = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case originalFileUrl = "url"
        case commentsCount = "num_comments"
        case postHint = "post_hint"
    }
 
}
