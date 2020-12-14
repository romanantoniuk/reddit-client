//
//  TopPostViewController.swift
//  Reddit client
//
//  Created by Roman Antoniuk on 12/11/20.
//  Copyright © 2020 Roman Antoniuk. All rights reserved.
//

import UIKit

final class TopPostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: TopPostViewModelProtocol?
    
    fileprivate var cellHeightDict: [IndexPath: CGFloat] = [:]
    fileprivate var isNowDragging: Bool = false
    fileprivate var isNeedRefreshData: Bool = true
    
    fileprivate var state: TopPostViewState = .initial {
        willSet {
            switch newValue {
            case .initial:
                tableView.backgroundView = nil
                tableView.reloadData()
            case .startLoading(let isPagination):
                if isPagination {
                    tableView.tableFooterView = LoadingView(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 50))
                } else {
                    tableView.backgroundView = nil
                    view.showLoading()
                }
            case .successLoad(let isPagination):
                if isPagination {
                    tableView.tableFooterView = nil
                } else {
                    view.hideLoading()
                }
                tableView.reloadData()
            case .failureLoad(let isPagination, let message):
                if isPagination {
                    tableView.tableFooterView = nil
                    view.showToastError(message)
                } else {
                    let plErrror = PlaceholderErrorView()
                    plErrror.messageLabel.text = message
                    plErrror.tappedRepeat = { [weak self] in
                        guard let self = self else { return }
                        self.viewModel?.refreshData()
                    }
                    tableView.backgroundView = plErrror
                    view.hideLoading()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TopPostViewModel()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedRefreshData {
            isNeedRefreshData = false
            viewModel?.refreshData()
        }
    }
    
    @IBAction func tapRefresh(_ sender: UIBarButtonItem) {
        viewModel?.refreshData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 4, left: 0, bottom: 4, right: 0)
        tableView.registerReusableCell(TopPostTableViewCell.self)
        viewModel?.updateUI = { [weak self] newState in
            guard let self = self else { return }
            self.state = newState
        }
    }
    
    private func createFooterSpinnerView() -> UIView {
        let footerView = UIView(frame: .init(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = AppColor.tintColor
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
    
}

extension TopPostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopPostTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let item = viewModel?.items[indexPath.row]
        cell.configureCell(with: item)
        cell.tappedToThumbnail = { [weak self] (originalFileUrl, postHint) in
            guard let self = self else { return }
            if postHint != "image" {
                if let url = URL(string: originalFileUrl) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, completionHandler: nil)
                    }
                }
            } else {
                let vc = ImagePreviewViewController.instantiate(with: .main)
                vc.urlImage = originalFileUrl
                vc.modalPresentationStyle = .popover
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightDict[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightDict[indexPath] ?? UITableView.automaticDimension
    }
    
}

extension TopPostViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isNowDragging = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height) {
            if isNowDragging, viewModel?.items.count != 0 {
                viewModel?.loadMore()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            isNowDragging = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isNowDragging = false
    }
    
}

extension TopPostViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let items = viewModel?.items, let itemEncode = try? JSONEncoder().encode(items) {
            coder.encode(itemEncode, forKey: "items")
            if let cellHeightDictEncode = try? JSONEncoder().encode(cellHeightDict) {
                coder.encode(cellHeightDictEncode, forKey: "cellHeightDict")
            }
            coder.encode(tableView.contentOffset.y, forKey: "position")
        }
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        isNeedRefreshData = false
        if let item = coder.decodeObject(forKey: "items") as? Data, let itemsDecoded = try? JSONDecoder().decode([DataPost].self, from: item), itemsDecoded.count > 0 {
            viewModel?.items = itemsDecoded
            if let itemCellHeightDict = coder.decodeObject(forKey: "cellHeightDict") as? Data, let cellHeightDictDecoded = try? JSONDecoder().decode([IndexPath: CGFloat].self, from: itemCellHeightDict) {
                cellHeightDict = cellHeightDictDecoded
            }
            state = .initial
            if let position = coder.decodeObject(forKey: "position") as? Double {
                tableView.contentOffset.y = CGFloat(position)
            }
        } else {
            viewModel?.refreshData()
        }
        super.decodeRestorableState(with: coder)
    }
    
}
