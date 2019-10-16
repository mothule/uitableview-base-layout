//
//  SelectItemTableViewCell.swift
//  TableView
//
//  Created by mothule on 2019/10/14.
//  Copyright © 2019 mothule. All rights reserved.
//

import UIKit


class SelectItemTableViewCell: UITableViewCell, Nibable {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var items: [Item] = []
    private var handler: ((IndexPath) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = layout
    }
    
    func setup(items: [Item], onTouched handler: @escaping (IndexPath) -> Void) {
        self.items = items
        self.handler = handler
    }
}

extension SelectItemTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCollectionViewCell.self, for: indexPath)
        cell.setup(item: items[indexPath.item])
        return cell
    }
}

extension SelectItemTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.handler?(indexPath)
    }
}

class ItemCollectionViewCell: UICollectionViewCell, Nibable {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func setup(item: Item) {
        let url = URL(string: item.imageURL)!
        URLSession.shared.dataTask(with: url) { [weak self] (data, res, error) in
            if let data = data {
                DispatchQueue.main.sync { [weak self] in
                    if let self = self {
                        self.imageView.image = UIImage(data: data)
                        self.imageView.setNeedsLayout()
                    }
                }
            }
        }.resume()
        nameLabel.text = item.name
        priceLabel.text = String(item.price)
    }
}

