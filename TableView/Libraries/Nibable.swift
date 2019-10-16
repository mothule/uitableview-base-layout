//
//  Nibable.swift
//  TableView
//
//  Created by mothule on 2019/10/09.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

extension NSObjectProtocol {
    static var className: String { return String(describing: self) }
    static var identifier: String { return className }
}

protocol Nibable: NSObjectProtocol {
  static var nibName: String { get }
  static var nib: UINib { get }
}
extension Nibable {
  static var nibName: String { return className }
  static var nib: UINib { return UINib(nibName: nibName, bundle: nil) }
}


extension UITableView {
    func register<T: UITableViewCell>(_ viewType: T.Type) where T: Nibable {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath ) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
