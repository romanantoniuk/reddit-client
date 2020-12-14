//
//  AppColor.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

enum AppColor {
    
    private enum ColorName: String {
        case mainColor
        case secondaryColor
        case textColor
        case secondaryTextColor
        case tintColor
    }
    
    static let mainColor = UIColor(named: ColorName.mainColor.rawValue) ?? UIColor(red: 0.196, green: 0.196, blue: 0.196, alpha: 1)
    static let secondaryColor = UIColor(named: ColorName.secondaryColor.rawValue) ?? UIColor(red: 0.804, green: 0.804, blue: 0.804, alpha: 1)
    static let textColor = UIColor(named: ColorName.textColor.rawValue) ?? UIColor(red: 0.902, green: 0.902, blue: 0.902, alpha: 0.902)
    static let secondaryTextColor = UIColor(named: ColorName.secondaryTextColor.rawValue) ?? UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 0.098)
    static let tintColor = UIColor(named: ColorName.tintColor.rawValue) ?? UIColor(red: 1, green: 0.298, blue: 0, alpha: 1)

}
