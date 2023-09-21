//
//  DetailBuilder.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation

class DetailBuilder {
    static func create(entity: DetailEntiy) -> DetailVC {
        let viewController = DetailVC(entity: entity)
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.output = presenter
        viewController.presenter = presenter
        
        let router = DetailRouterImpl(viewController: viewController)
        presenter.router = router
        
        return viewController
    }
}
