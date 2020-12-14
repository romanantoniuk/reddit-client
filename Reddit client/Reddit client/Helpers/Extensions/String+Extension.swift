//
//  String+Extension.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/14/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

extension String {
    
    func localized(with count: Int) -> String {
        let formatString: String = NSLocalizedString(self, comment: "\(self) in Localized.stringsdict")
        let resultString: String = String.localizedStringWithFormat(formatString, count)
        return resultString;
    }
    
}
