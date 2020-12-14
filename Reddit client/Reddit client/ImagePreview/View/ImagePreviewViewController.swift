//
//  ImagePreviewViewController.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/14/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit
import Photos

final class ImagePreviewViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var urlImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureImage()
    }
    
    private func configureUI() {
        scrollView.delegate = self
        saveBarButton.isEnabled = false
        cancelBarButton.isEnabled = false
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = previewImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let photosAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            let message: String?
            switch photosAuthorizationStatus {
            case .restricted, .denied, .notDetermined:
                message = "Access denied, please allow our app permission through \"Settings\" on your phone"
            case .authorized:
                message = error.localizedDescription
            @unknown default:
                message = "Unknown error"
            }
            let ac = UIAlertController(title: "Save error", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func configureImage() {
        if let url = urlImage {
            previewImageView.loadImageWithCompletion(stringUrl: url) { [weak self] success in
                guard let self = self else { return }
                if success {
                    self.saveBarButton.isEnabled = true
                    self.cancelBarButton.isEnabled = true
                } else {
                    self.cancelBarButton.isEnabled = true
                }
            }
        }
    }

}

extension ImagePreviewViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return previewImageView
    }
    
}

extension ImagePreviewViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let item = urlImage {
            coder.encode(item, forKey: "urlImage")
        }
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let item = coder.decodeObject(forKey: "urlImage") as? String {
            urlImage = item
        }
        super.decodeRestorableState(with: coder)
    }
    
}


