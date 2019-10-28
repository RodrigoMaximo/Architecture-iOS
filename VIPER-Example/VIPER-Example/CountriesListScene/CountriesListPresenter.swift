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
    func selectCountry(at row: Int)
}

protocol CountriesListPresenterDelegate: AnyObject {
    // The necessity of implement these methods is because the `reloadCountries()` and `orderCountries()` could be async.
    func didReloadCountries()
    func didOrderCountries()
}

final class CountriesListPresenter: CountriesListPresenterProtocol {

    let interactor: CountriesListInteractorProtocol
    weak var delegate: CountriesListPresenterDelegate?

    var numberOfCountries: Int {
        return interactor.countries.count
    }

    init(interactor: CountriesListInteractorProtocol) {
        self.interactor = interactor
    }

    func reloadCountries() {
        interactor.reloadCountries()
    }

    func orderCountries(accordingTo segmentedIndex: Int) {
        interactor.orderCountries(accordingTo: segmentedIndex)
    }

    func segmentedNames() -> [String] {
        return interactor.segmentedNames()
    }

    func viewModelFor(row: Int, segmentedIndex: Int) -> CountriesListTableViewCell.ViewModel {
        let country = interactor.countries[row]
        let description = interactor.descriptionFor(row: row, segmentedIndex: segmentedIndex)
        return CountriesListTableViewCell.ViewModel(imageName: country.name,
                                                    description: description)
    }

    func selectCountry(at row: Int) {
        return interactor.selectCountry(at: row)
    }
}

extension CountriesListPresenter: CountriesListInteractorDelegate {
    func didOrderedCountries() {
        delegate?.didOrderCountries()
    }

    func didReloadCountries() {
        delegate?.didReloadCountries()
    }
}
