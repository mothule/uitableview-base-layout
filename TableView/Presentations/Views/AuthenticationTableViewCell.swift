//
//  AuthenticationTableViewCell.swift
//  TableView
//
//  Created by mothule on 2019/10/17.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationTableViewCell: UITableViewCell, Nibable {
    typealias AuthenticateHandler = () -> Void
    private var handler: AuthenticateHandler?
    
    func setup(handler: @escaping AuthenticateHandler) {
        self.handler = handler
    }
    
    @IBAction func onTouchedButton(_ sender: Any) {
        handler?()
    }
}
