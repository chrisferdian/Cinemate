//
//  MainBuilder.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 20/09/23.
//

import Foundation
class MainBuilder {
    static func create() -> MainVC {
        let mainViewController = MainVC()
        let mainInteractor = MainInteractor()
        let mainPresenter = MainPresenter()
        mainPresenter.view = mainViewController
        mainPresenter.interactor = mainInteractor
        mainInteractor.output = mainPresenter
        mainViewController.presenter = mainPresenter
        
        let mainRouter = MainRouterImpl(viewController: mainViewController)
        mainPresenter.router = mainRouter

        return mainViewController
    }
}
