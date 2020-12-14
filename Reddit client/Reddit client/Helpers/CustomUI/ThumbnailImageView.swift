//
//  ThumbnailImageView.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/12/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

final class ThumbnailImageView: UIImageView {
    
    var urlImage: String?
    
    func loadImage(stringUrl: String) {
        if urlImage == stringUrl {
            let urlComponent = URLComponents(string: stringUrl)
            guard let url = urlComponent?.url, urlComponent?.scheme != nil else {
                isHidden = true
                return
            }
            image = nil
            if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) {
                image = imageFromCache as? UIImage
                return
            }
            showLoading()
            NetworkLayer.downloadImage(url: url) { [weak self] result in
                guard let self = self else { return }
                if self.urlImage == stringUrl {
                    self.hideLoading()
                    switch result {
                    case .success(let data):
                        guard let imageToCache = UIImage(data: data) else { return }
                        imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                        self.image = UIImage(data: data)
                    case .failure(_):
                        self.image = UIImage(named: "ImagePlaceHolder")
                    }
                }
            }
        }
    }
    
}

