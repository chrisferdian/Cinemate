//
//  MainRouter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 20/09/23.
//

import UIKit

protocol MainRouter {
    // Define navigation methods
}

class MainRouterImpl: MainRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // Implement navigation methods as needed
}
