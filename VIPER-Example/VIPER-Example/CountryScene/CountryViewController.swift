//
//  EmptyViewController.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class CountryViewController: UIViewController {

    @IBOutlet private weak var mainImageView: UIImageView?
    var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainImageView()
    }

    private func setupMainImageView() {
        guard let country = self.country else {
            return
        }
        mainImageView?.image = UIImage(named: country.name)
        mainImageView?.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mainImageView?.layer.borderWidth = 3
    }
}
