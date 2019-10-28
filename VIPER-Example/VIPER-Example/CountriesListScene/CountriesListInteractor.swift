//
//  CountriesListInteractor.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

protocol CountriesListInteractorProtocol {
    var countries: [Country] { get }
    func orderCountries(accordingTo segmentedIndex: Int)
    func segmentedNames() -> [String]
    func descriptionFor(row: Int, segmentedIndex: Int) -> String
    func reloadCountries()
    func selectCountry(at row: Int)
}

protocol CountriesListInteractorDelegate: AnyObject {
    func didOrderedCountries()
    func didReloadCountries()
}

final class CountriesListInteractor: CountriesListInteractorProtocol {

    enum Segmented: Int, CaseIterable {
        case names = 0
        case hdi

        var stringValue: String {
            switch self {
            case .names:
                return "Names"
            case .hdi:
                return "HDI"
            }
        }
    }

    weak var delegate: CountriesListInteractorDelegate?
    var countries: [Country] = []
    let dataFlow: CountriesListDataFlowProtocol

    init(countries: [Country] = [], dataFlow: CountriesListDataFlowProtocol) {
        self.countries = countries
        self.dataFlow = dataFlow
    }

    func orderCountries(accordingTo segmentedIndex: Int) {
        guard let segmented = Segmented(rawValue: segmentedIndex) else {
            return
        }
        if segmented == .names {
            countries = countries.sorted{ $0.name < $1.name }
        } else {
            countries = countries.sorted{ $0.hdi > $1.hdi }
        }
        delegate?.didOrderedCountries()
    }

    func segmentedNames() -> [String] {
        return Segmented.allCases.map { $0.stringValue }
    }

    func descriptionFor(row: Int, segmentedIndex: Int) -> String {
        guard let segmented = Segmented(rawValue: segmentedIndex) else {
            return ""
        }
        return segmented == .names ? countries[row].name : String(countries[row].hdi)
    }

    func reloadCountries() {
        countries = CountriesProvider.provide(10)
        delegate?.didReloadCountries()
    }

    func selectCountry(at row: Int) {
        dataFlow.selectedCountry = countries[row]
    }
}
