//
//  ViewModel.swift
//  TableView
//
//  Created by mothule on 2019/10/17.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation

protocol ViewModelDelegate {
    func onChangedValue(viewModel: ViewModel)
    func navigateAuthentication()
    func navigateItemList()
    func navigateItemDetail(item: Item)
}

class ViewModel {
    private(set) var imageURLs: [String] = []
    private(set) var isSigningIn: Bool = false
    private(set) var items: [Item] = []
    private(set) var rankingItems: [Item] = []
    
    var delegate: ViewModelDelegate?
    
    func signState(isSigningIn: Bool) {
        self.isSigningIn = isSigningIn
        delegate?.onChangedValue(viewModel: self)
    }
    
    func fireAuthenticate() {
        delegate?.navigateAuthentication()
    }
    
    func navigateItemList() {
        delegate?.navigateItemList()
    }
    
    func navigateItemDetail(item: Item) {
        delegate?.navigateItemDetail(item: item)
    }
    
    
    func fetchTopPage() {
        ApiClient.shared.getTopPage { [weak self] response in
            guard let self = self else { return }
            self.parseResponse(response)
        }
    }
    
    func makeSectionTypes() -> [SectionType] {
        var sections: [SectionType] = []
        if imageURLs.count > 0 {
            sections.append(.carousel)
        }
        if isSigningIn == false {
            sections.append(.authenticate)
        }
        if items.isEmpty == false {
            sections.append(.itemSelection)
        }
        if rankingItems.isEmpty == false {
            sections.append(.itemRanking)
        }

        return sections
    }
    
    func rowCount(for section: SectionType) -> Int {
        switch section {
        case .carousel: return imageURLs.isEmpty ? 0 : 1
        case .authenticate: return isSigningIn ? 0 : 1
        case .itemSelection: return items.isEmpty ? 0 : 2
        case .itemRanking: return rankingItems.isEmpty ? 0 : 1 + rankingItems.count
        }
    }
    
    func isTouchableCell(path indexPath: IndexPath) -> Bool {
        guard let section = SectionType(rawValue: indexPath.section) else { return false }
        return section == .itemRanking && indexPath.row != 0
    }
    
    func touchCell(path indexPath: IndexPath) {
        guard isTouchableCell(path: indexPath) else { return }

        let index = indexPath.row - 1
        let item = rankingItems[index]
        navigateItemDetail(item: item)
    }
    
    func touchSelectionItem(path indexPath: IndexPath) {
        let item = items[indexPath.item]
        navigateItemDetail(item: item)
    }
    
    private func parseResponse(_ response: TopPageResponse) {
        defer {
            delegate?.onChangedValue(viewModel: self)
        }
        imageURLs = response.carouselImageURLs
        items = response.items
        rankingItems = response.rankingItems
    }

}
