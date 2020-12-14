//
//  UIImageView+Extension.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/14/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageWithCompletion(stringUrl: String, completion: @escaping ((_ success: Bool)->())) {
        let urlComponent = URLComponents(string: stringUrl)
        guard let url = urlComponent?.url, urlComponent?.scheme != nil else {
            completion(false)
            return
        }
        image = nil
        if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) {
            image = imageFromCache as? UIImage
            completion(true)
            return
        }
        showLoading()
        NetworkLayer.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                self.image = UIImage(data: data)
                completion(true)
            case .failure(_):
                self.image = nil
                completion(false)
            }
        }
    }
}

