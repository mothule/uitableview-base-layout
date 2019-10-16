//
//  UIPageControl+Extension.swift
//  TableView
//
//  Created by mothule on 2019/10/14.
//  Copyright © 2019 mothule. All rights reserved.
//

import Foundation
import UIKit

extension UIPageControl {
    enum MoveDir {
        case next
        case previous
    }
    
    func movePage(dir: MoveDir) {
        switch dir {
        case .next:
            currentPage = currentPage + 1 < numberOfPages ? currentPage + 1 : 0
        case .previous:
            currentPage = currentPage - 1 >= 0 ? currentPage - 1 : numberOfPages - 1
        }
    }
}
