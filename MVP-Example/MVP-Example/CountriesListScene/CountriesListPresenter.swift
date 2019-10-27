//
//  CountriesListPresenter.swift
//  MVP-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

protocol CountriesListPresenterProtocol {
    var numberOfCountries: Int { get }
    func reloadCountries()
    func orderCountries(accordingTo segmentedIndex: Int)
    func segmentedNames() -> [String]
    func viewModelFor(row: Int, segmentedIndex: Int) -> CountriesListTableViewCell.ViewModel
    func selectedCountry(for row: Int) -> Country
}

protocol CountriesListPresenterDelegate: AnyObject {
    // The necessity of implement these methods is because the `reloadCountries()` and `orderCountries()` could be async.
    func didReloadCountries()
    func didOrderCountries()
}

final class CountriesListPresenter: CountriesListPresenterProtocol {

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

    weak var delegate: CountriesListPresenterDelegate?
    private var countries: [Country] = []

    var numberOfCountries: Int {
        return countries.count
    }

    func reloadCountries() {
        countries = CountriesProvider.provide(10)
        delegate?.didReloadCountries()
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
        delegate?.didOrderCountries()
    }

    func segmentedNames() -> [String] {
        return Segmented.allCases.map { $0.stringValue }
    }

    func viewModelFor(row: Int, segmentedIndex: Int) -> CountriesListTableViewCell.ViewModel {
        let country = countries[row]
        let description = Segmented(rawValue: segmentedIndex) == .some(.names) ? country.name : String(country.hdi)
        return CountriesListTableViewCell.ViewModel(imageName: country.name,
                                                    description: description)
    }

    func selectedCountry(for row: Int) -> Country {
        return countries[row]
    }
}
