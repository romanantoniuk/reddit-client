//
//  Result.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
    
}
