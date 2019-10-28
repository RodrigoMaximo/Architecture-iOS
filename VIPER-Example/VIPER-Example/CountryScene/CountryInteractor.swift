//
//  CountryInteractor.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

protocol CountryInteractorProtocol {
    var country: Country { get }
}

protocol CountryInteractorDelegate: AnyObject {}

final class CountryInteractor: CountryInteractorProtocol {
    weak var delegate: CountryInteractorDelegate?
    let country: Country

    init(country: Country) {
        self.country = country
    }
}
