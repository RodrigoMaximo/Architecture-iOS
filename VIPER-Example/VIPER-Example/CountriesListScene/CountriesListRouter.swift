//
//  CountriesListRouter.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

protocol CountriesListRouterProtocol {
    static func make() -> CountriesListViewController?
    func presentCountryScene(from view: UIViewController)
}

final class CountriesListRouter: CountriesListRouterProtocol {

    let dataFlow: CountriesListDataFlowProtocol

    init(dataFlow: CountriesListDataFlowProtocol) {
        self.dataFlow = dataFlow
    }

    static func make() -> CountriesListViewController? {
        let viewController = UIStoryboard.viewController(of: CountriesListViewController.self,
                                                         storyboardId: .countriesList)
        let dataFlow = CountriesListDataFlow()
        let interactor = CountriesListInteractor(dataFlow: dataFlow)
        let router = CountriesListRouter(dataFlow: dataFlow)
        let presenter = CountriesListPresenter(interactor: interactor)

        viewController?.router = router
        viewController?.presenter = presenter
        presenter.delegate = viewController
        interactor.delegate = presenter

        return viewController
    }

    func presentCountryScene(from view: UIViewController) {
        guard
            let selectedCountry = dataFlow.selectedCountry,
            let nextViewController = CountryRouter.make(country: selectedCountry) else
        {
            return
        }
        view.present(nextViewController, animated: true, completion: nil)
    }
}
