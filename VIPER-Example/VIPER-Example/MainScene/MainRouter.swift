//
//  MainRouter.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

protocol MainRouterProtocol {
    static func make() -> MainViewController?
    func presentListCountriesScene(from navigation: UINavigationController)
}

final class MainRouter: MainRouterProtocol {
    static func make() -> MainViewController? {
        let viewController = UIStoryboard.viewController(of: MainViewController.self,
                                                         storyboardId: .main)
        let router = MainRouter()
        viewController?.router = router
        
        return viewController
    }

    func presentListCountriesScene(from navigation: UINavigationController) {
        guard let nextViewController = CountriesListRouter.make() else {
            return
        }
        navigation.pushViewController(nextViewController, animated: true)
    }
}
