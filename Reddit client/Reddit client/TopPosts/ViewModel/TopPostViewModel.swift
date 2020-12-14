//
//  TopPostViewModel.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import Foundation

final class TopPostViewModel: TopPostViewModelProtocol {
    
    var updateUI: ((TopPostViewState) -> ())?
    
    var items: [DataPost] = [] {
        didSet {
            lastItemName = items.last?.name
        }
    }
    
    var lastItemName: String?
        
    lazy private var networkService = PostService.shared
    private var isNowLoading: Bool = false
    
    func refreshData() {
        items = []
        updateUI?(.initial)
        loadData()
    }
    
    func loadMore() {
        loadData(isPagination: true)
    }
    
    private func loadData(isPagination: Bool = false) {
        guard !isNowLoading else {
            return
        }
        isNowLoading = true
        updateUI?(.startLoading(isPagination))
        networkService.getTopPosts(after: lastItemName, count: items.count) { [weak self] (newItems, error) in
            guard let self = self else { return }
            if let error = error {
                self.updateUI?(.failureLoad(isPagination, error))
            } else {
                self.items.append(contentsOf: newItems)
                self.updateUI?(.successLoad(isPagination))
            }
            self.isNowLoading = false
        }
    }
    
}
