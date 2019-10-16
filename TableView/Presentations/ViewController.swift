//
//  ViewController.swift
//  TableView
//
//  Created by mothule on 2019/09/26.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let dataSource = DataSource()
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Refresh control
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
        
        // Table
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
        tableView.delaysContentTouches = false
        
        dataSource.setup(tableView: tableView, viewModel: viewModel)
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.signState(isSigningIn: true)
        viewModel.fetchTopPage()
    }
    
    @objc private func onRefresh(_ sender: AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
}

extension ViewController: ViewModelDelegate {
    func navigateAuthentication() {
        print("Navigate authentication view controller")
    }
    
    func navigateItemDetail(item: Item) {
        print("Navigate item detail view controller. \(item)")
    }
    
    func navigateItemList() {
        print("Navigate item list view controller.")
    }
    
    func onChangedValue(viewModel: ViewModel) {
        dataSource.refresh()
    }
}
