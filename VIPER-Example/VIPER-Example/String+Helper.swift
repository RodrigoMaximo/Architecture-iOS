//
//  String+Helper.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

extension String {
    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}
