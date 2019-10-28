//
//  UIStoryboard+Helper.swift
//  VIPER-Example
//
//  Created by Rodrigo Máximo on 28/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

enum StoryboardId: String {
    case countriesList
    case country
    case main

    var key: String {
        return rawValue.capitalizingFirstLetter
    }
}

extension UIStoryboard {
    static func viewController<T: UIViewController>(of type: T.Type, storyboardId: StoryboardId) -> T? {
        return UIStoryboard(name: storyboardId.key,
                            bundle: .none).instantiateInitialViewController() as? T
    }
}
