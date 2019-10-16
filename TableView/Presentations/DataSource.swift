//
//  DataSource.swift
//  TableView
//
//  Created by mothule on 2019/10/09.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

class DataSource: NSObject, UITableViewDataSource {
    private var viewModel: ViewModel!
    private var sections: [SectionType] = []
    private weak var tableView: UITableView?
    
    func setup(tableView: UITableView, viewModel: ViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        self.sections = viewModel.makeSectionTypes()
    }
    
    func refresh() {
        sections = viewModel.makeSectionTypes()
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        return viewModel.rowCount(for: sectionType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]

        let ret: UITableViewCell
        switch section {
        case .carousel:
            let cell = tableView.dequeueReusableCell(CarouselTableViewCell.self, for: indexPath)
            cell.setup(imageURLs: viewModel.imageURLs)
            ret = cell
            
        case .authenticate:
            let cell = tableView.dequeueReusableCell(AuthenticationTableViewCell.self, for: indexPath)
            cell.setup { [weak self] in
                self?.viewModel?.fireAuthenticate()
            }
            ret = cell
            
        case .itemSelection:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(SelectItemHeaderTableViewCell.self, for: indexPath)
                cell.setup { [weak self] in
                    self?.viewModel?.navigateItemList()
                }
                ret = cell

            } else {
                let cell = tableView.dequeueReusableCell(SelectItemTableViewCell.self, for: indexPath)
                cell.setup(items: viewModel.items, onTouched: { indexPath in
                    self.viewModel.touchSelectionItem(path: indexPath)
                })
                ret = cell
            }
            
        case .itemRanking:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(RecommendedItemHeaderTableViewCell.self, for: indexPath)
                ret = cell
            } else {
                let cell = tableView.dequeueReusableCell(RecommendedItemTableViewCell.self, for: indexPath)
                cell.setup(item: viewModel.items[indexPath.row - 1])
                ret = cell
            }
        }
        
        return ret
    }
}

extension DataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel.isTouchableCell(path: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.touchCell(path: indexPath)
    }
}
