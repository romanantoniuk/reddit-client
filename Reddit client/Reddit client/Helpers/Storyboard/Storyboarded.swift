//
//  Storyboarded.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

protocol Storyboarded {
    
    static func instantiate(with storyboard: StoryboardName) -> Self
    
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(with storyboard: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}

