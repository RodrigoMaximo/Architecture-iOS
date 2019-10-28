//
//  CountryPresenter.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

protocol CountryPresenterProtocol {
    var imageName: String { get }
}

protocol CountryPresenterDelegate: AnyObject {}

final class CountryPresenter: CountryPresenterProtocol {
    let interactor: CountryInteractorProtocol
    weak var delegate: CountryPresenterDelegate?

    init(interactor: CountryInteractorProtocol) {
        self.interactor = interactor
    }

    var imageName: String {
        return interactor.country.name
    }
}

extension CountryPresenter: CountryInteractorDelegate {}
