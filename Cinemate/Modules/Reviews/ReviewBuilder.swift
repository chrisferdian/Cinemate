//
//  ReviewBuilder.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation


class ReviewBuilder {
    static func create(entity: DetailEntiy) -> ReviewsVC {
        let controller = ReviewsVC(entity: entity)
        let presenter = ReviewsPresenter()
        let interactor = ReviewsInteractor()
        
        presenter.view = controller
        presenter.interactor = interactor
        interactor.output = presenter
        controller.presenter = presenter

        return controller
    }
}
