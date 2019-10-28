//
//  UITableView+Reusable.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(_ cellType: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType)) as? T
    }
}
