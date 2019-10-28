//
//  CountryRouter.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

protocol CountryRouterProtocol {
    static func make(country: Country) -> CountryViewController?
}

final class CountryRouter: CountryRouterProtocol {
    static func make(country: Country) -> CountryViewController? {
        let viewController = UIStoryboard.viewController(of: CountryViewController.self,
                                                         storyboardId: .country)
        let interactor = CountryInteractor(country: country)
        let presenter = CountryPresenter(interactor: interactor)

        viewController?.presenter = presenter
        presenter.delegate = viewController
        interactor.delegate = presenter

        return viewController
    }
}

