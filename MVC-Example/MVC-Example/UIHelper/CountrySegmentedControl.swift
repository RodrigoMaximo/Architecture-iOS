//
//  SegmentedControl.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class CountrySegmentedControl: UISegmentedControl {

    enum SelectionType {
        case name
        case hdi
    }

    var selectedType: SelectionType {
        switch selectedSegmentIndex {
        case 0:
            return .name
        default:
            return .hdi
        }
    }
}
