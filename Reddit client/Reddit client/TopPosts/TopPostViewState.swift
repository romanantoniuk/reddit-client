//
//  TopPostViewState.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/13/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

enum TopPostViewState {
    
    case initial
    case startLoading(_ isPagination: Bool)
    case successLoad(_ isPagination: Bool)
    case failureLoad(_ isPagination: Bool, _ message: String)
    
}
