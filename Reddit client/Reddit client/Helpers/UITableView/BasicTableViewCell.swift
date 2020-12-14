//
//  BasicTableViewCell.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell, Reusable {
    
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
        
    private func initUI() {
        selectionStyle = .none
        configureUI()
        resetDataUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetDataUI()
    }
    
    func configureUI() {}
    
    func resetDataUI() {}

}
