//
//  MainViewController.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    var router: MainRouterProtocol = MainRouter() // first screen

    @IBAction func didTouchStart(_ sender: UIButton) {
        guard let navigationController = self.navigationController else {
            return
        }
        router.presentListCountriesScene(from: navigationController)
    }
}
