//
//  SelectItemHeaderTableViewCell.swift
//  TableView
//
//  Created by mothule on 2019/10/14.
//  Copyright © 2019 mothule. All rights reserved.
//

import UIKit

class SelectItemHeaderTableViewCell: UITableViewCell, Nibable {
    
    typealias Handler = () -> Void
    
    private var handler: Handler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(onTouched handler: @escaping Handler) {
        self.handler = handler
    }
        
    @IBAction func onTouchedMoreButton(_ sender: Any) {
        handler?()
    }
}
