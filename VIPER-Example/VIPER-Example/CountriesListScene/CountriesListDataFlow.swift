//
//  CountriesListDataFlow.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

protocol CountriesListDataFlowProtocol: AnyObject {
    var selectedCountry: Country? { get set }
}

final class CountriesListDataFlow: CountriesListDataFlowProtocol {
    var selectedCountry: Country?
}
