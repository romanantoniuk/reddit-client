//
//  UIView+Extensions.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/12/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: padding.top))
        }
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom))
        }
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: padding.left))
        }
        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -padding.right))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func anchorGreaterThanOrEqualTo(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if let top = top {
            constraints.append(topAnchor.constraint(greaterThanOrEqualTo: top, constant: padding.top))
        }
        if let bottom = bottom {
            constraints.append(bottom.constraint(greaterThanOrEqualTo: bottomAnchor, constant: padding.bottom))
        }
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(greaterThanOrEqualTo: leading, constant: padding.left))
        }
        if let trailing = trailing {
            constraints.append(trailing.constraint(greaterThanOrEqualTo: trailingAnchor, constant: padding.right))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func anchorCentre(xAxis: NSLayoutXAxisAnchor?, _ xConstant: CGFloat = 0, yAxis: NSLayoutYAxisAnchor?, _ yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if let xAxis = xAxis {
            constraints.append(centerXAnchor.constraint(equalTo: xAxis, constant: xConstant))
        }
        if let yAxis = yAxis {
            constraints.append(centerYAnchor.constraint(equalTo: yAxis, constant: yConstant))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func anchorSize(_ size: CGSize, hPriority: UILayoutPriority? = nil, wPriority: UILayoutPriority? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        if size.height != 0 {
            let hConstraint = heightAnchor.constraint(equalToConstant: size.height)
            if let hPriority = hPriority {
                hConstraint.priority = hPriority
            }
            constraints.append(hConstraint)
        }
        if size.width != 0 {
            let wConstraint = widthAnchor.constraint(equalToConstant: size.width)
            if let wPriority = wPriority {
                wConstraint.priority = wPriority
            }
            constraints.append(wConstraint)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    static let tagLoadingIndicator = 9901
    static let tagToastView = 9902

    func showLoading() {
        removeToastError()
        if (viewWithTag(UIView.tagLoadingIndicator) != nil) {
            viewWithTag(UIView.tagLoadingIndicator)?.removeFromSuperview()
        }
        isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tag = UIView.tagLoadingIndicator
        addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = AppColor.tintColor
        activityIndicator.anchorSize(.init(width: 50, height: 50))
        activityIndicator.anchorCentre(xAxis: centerXAnchor, yAxis: centerYAnchor)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        if (viewWithTag(UIView.tagLoadingIndicator) != nil) {
            viewWithTag(UIView.tagLoadingIndicator)?.removeFromSuperview()
        }
        isUserInteractionEnabled = true
    }
    
    func showToastError(_ message: String) {
        removeToastError()
        let viewToast = UIView()
        viewToast.layer.cornerRadius = 16
        viewToast.backgroundColor = AppColor.secondaryColor.withAlphaComponent(0.5)
        viewToast.alpha = 0
        viewToast.tag = UIView.tagToastView
        addSubview(viewToast)
        viewToast.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        viewToast.anchorCentre(xAxis: safeAreaLayoutGuide.centerXAnchor, yAxis: nil)
        viewToast.anchorGreaterThanOrEqualTo(top: nil, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.textColor = AppColor.secondaryTextColor
        textLabel.numberOfLines = 0
        textLabel.text = message
        textLabel.alpha = 0
        viewToast.addSubview(textLabel)
        textLabel.anchor(top: viewToast.topAnchor, bottom: viewToast.bottomAnchor, leading: viewToast.leadingAnchor, trailing: viewToast.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        UIView.animateKeyframes(withDuration: 0.3 , delay: 0, options: [] , animations: {
            viewToast.alpha = 1
            textLabel.alpha = 1
        }, completion: {
            success in
            UIView.animate(withDuration: 0.3, delay: 3, options: [] , animations: {
                textLabel.alpha = 0
                viewToast.alpha = 0
            }) { (finished) in
                viewToast.removeFromSuperview()
            }
        })
    }
    
    func removeToastError() {
        if (viewWithTag(UIView.tagToastView) != nil) {
            viewWithTag(UIView.tagToastView)?.removeFromSuperview()
        }
    }
    
}
