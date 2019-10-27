//
//  SportTableViewCell.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class CountriesListTableViewCell: UITableViewCell {

    struct ViewModel {
        let imageName: String
        let description: String
    }

    @IBOutlet private weak var mainImageView: UIImageView?
    @IBOutlet private weak var descriptionLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView?.layer.borderWidth = 1
        mainImageView?.layer.borderColor = UIColor.black.cgColor
    }

    func render(viewModel: ViewModel) {
        mainImageView?.image = UIImage(named: viewModel.imageName)
        descriptionLabel?.text = viewModel.description
    }
}
