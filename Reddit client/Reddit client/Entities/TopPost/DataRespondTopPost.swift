//
//  DataRespondTopPost.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

struct DataRespondTopPost: Codable {
    
    var children: [ChildrenDataRespondTopPost]
    var after: String?
    var before: String?

}
