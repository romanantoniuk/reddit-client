//
//  TopPostViewModelProtocol.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

protocol TopPostViewModelProtocol {
    
    var updateUI: ((TopPostViewState) -> ())? { set get }
    var items: [DataPost] { get set }
    
    func refreshData()
    func loadMore()
    
}
