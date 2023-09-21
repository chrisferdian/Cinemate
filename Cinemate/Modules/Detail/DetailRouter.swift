//
//  DetailRouter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

protocol DetailRouter {
    func navigateToReviews(entity: DetailEntiy)
}

class DetailRouterImpl: DetailRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToReviews(entity: DetailEntiy) {
        viewController?.navigationController?.pushViewController(ReviewBuilder.create(entity: entity), animated: true)
    }
}
