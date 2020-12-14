//
//  PlaceholderErrorView.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/14/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

final class PlaceholderErrorView: UIView {
    
    lazy private var imagePreviewView: UIImageView = {
        let imageView = UIImageView()
        imageView.anchorSize(.init(width: 100, height: 100))
        imageView.image = UIImage(named: "errorNetworkingIcon")
        imageView.tintColor = AppColor.tintColor
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = AppColor.textColor
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.setContentCompressionResistancePriority(.init(rawValue: 751), for: .horizontal)
        return label
    }()
    
    lazy private var buttonRepeat: UIButton = {
        let button = UIButton()
        button.setTitle("Repeat?", for: .normal)
        button.setTitleColor(AppColor.tintColor, for: .normal)
        button.addTarget(self, action: #selector(tapRepeat), for: .touchUpInside)
        return button
    }()
    
    var tappedRepeat: (()->())? {
        willSet {
            if newValue != nil {
                buttonRepeat.isHidden = false
            } else {
                buttonRepeat.isHidden = true
            }
        }
    }

    @objc private func tapRepeat() {
        tappedRepeat?()
    }
    
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
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.anchorCentre(xAxis: centerXAnchor, yAxis: centerYAnchor)
        stackView.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        stackView.addArrangedSubview(imagePreviewView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(buttonRepeat)
        buttonRepeat.isHidden = true
    }
    
}
