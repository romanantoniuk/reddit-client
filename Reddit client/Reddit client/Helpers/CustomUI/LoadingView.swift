//
//  LoadingView.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/14/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    lazy private var spinner: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = AppColor.tintColor
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(spinner)
        spinner.anchorCentre(xAxis: centerXAnchor, yAxis: centerYAnchor)
    }
    
}
