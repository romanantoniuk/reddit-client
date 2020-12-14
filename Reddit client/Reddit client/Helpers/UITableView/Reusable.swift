//
//  Reusable.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

protocol Reusable {
    
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
        
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return nil
    }
    
}
