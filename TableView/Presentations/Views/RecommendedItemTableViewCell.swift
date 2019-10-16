//
//  RecommendedItemTableViewCell.swift
//  TableView
//
//  Created by mothule on 2019/10/16.
//  Copyright © 2019 mothule. All rights reserved.
//

import UIKit

class RecommendedItemHeaderTableViewCell: UITableViewCell, Nibable {
}

class RecommendedItemTableViewCell: UITableViewCell, Nibable {
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(item: Item) {
        
        let url = URL(string: item.imageURL)!
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let data = data {
                DispatchQueue.main.sync { [weak self] in
                    self?.itemImageView.image = UIImage(data: data)
                    self?.itemImageView.setNeedsLayout()
                }
            }
        }.resume()
        
        nameLabel.text = item.name
        priceLabel.text = String(item.price)
    }
}
