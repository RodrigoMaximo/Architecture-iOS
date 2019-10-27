//
//  Country.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

struct Country {
    let name: String
    let continent: Continent
    let population: Int
    let hdi: Double
}

extension Country: Hashable {
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
}
