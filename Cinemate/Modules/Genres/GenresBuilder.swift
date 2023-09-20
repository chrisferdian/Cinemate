//
//  GenresBuilder.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation

class GenresBuilder {
    static func create() -> GenresVC {
        let viewController = GenresVC()
        let presenter = GenresPresenter()
        let interactor = GenresInteractor()
        
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.output = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}
