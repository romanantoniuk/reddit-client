//
//  TopPostTableViewCell.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/12/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

final class TopPostTableViewCell: BasicTableViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var thumbnailImageView: ThumbnailImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var thumbnailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var thumbnailWidthConstraint: NSLayoutConstraint!
    
    var tappedToThumbnail: ((_ thumbnailUrl: String, _ postHint: String?)->())?
    
    private var originalFileUrl: String?
    private var postHint: String?

    @objc private func tapThumbnail() {
        if let originalFileUrl = originalFileUrl {
            tappedToThumbnail?(originalFileUrl, postHint)
        }
    }
    
    override func configureUI() {
        rootView.layer.cornerRadius = 4
        rootView.layer.shadowColor = AppColor.secondaryColor.withAlphaComponent(0.5).cgColor
        rootView.layer.shadowOpacity = 0.2
        rootView.layer.shadowOffset = .init(width: 0, height: 2)
        rootView.layer.shadowRadius = 2
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.isUserInteractionEnabled = true
        thumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapThumbnail)))
        titleTextView.contentInset = .zero
    }
    
    override func resetDataUI() {
        authorLabel.text = nil
        timeAgoLabel.text = nil
        titleTextView.text = nil
        thumbnailImageView.image = nil
        thumbnailImageView.isHidden = false
        thumbnailWidthConstraint.constant = 70
        thumbnailHeightConstraint.constant = 70
        commentsCountLabel.text = nil
        thumbnailImageView.hideLoading()
        thumbnailImageView.urlImage = nil
        originalFileUrl = nil
        postHint = nil
    }
    
    func configureCell(with item: DataPost?) {
        guard let item = item else { return }
        authorLabel.text = item.author
        timeAgoLabel.text = Date(timeIntervalSince1970: TimeInterval(item.datePublish)).getElapsedInterval()
        titleTextView.text = item.title
        commentsCountLabel.text = "count.comments".localized(with: item.commentsCount ?? 0)
        postHint = item.postHint
        originalFileUrl = item.originalFileUrl
        if let thumbnailUrl = item.thumbnailUrl {
            if let widthThumbnail = item.thumbnailWidth, let heightThumbnail = item.thumbnailHeight {
                thumbnailWidthConstraint.constant = CGFloat(widthThumbnail) / 2
                thumbnailHeightConstraint.constant = CGFloat(heightThumbnail) / 2
            }
            thumbnailImageView.urlImage = thumbnailUrl
            thumbnailImageView.loadImage(stringUrl: thumbnailUrl)
        } else {
            thumbnailImageView.isHidden = true
        }
    }
    
}
