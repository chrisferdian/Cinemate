//
//  MainRouter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 20/09/23.
//

import UIKit

protocol MainRouter {
    // Define navigation methods
    func navigateToGenres(pickerDelegate: IDataPickerDelegate)
    func navigateToDetail(entity: DetailEntiy)
}

class MainRouterImpl: MainRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // Implement navigation methods as needed
    func navigateToGenres(pickerDelegate: IDataPickerDelegate) {
        let vc = GenresBuilder.create()
        vc.modalPresentationStyle = .overFullScreen
        vc.dataPickerDelegate = pickerDelegate
        viewController?.present(vc, animated: true)
    }
    
    func navigateToDetail(entity: DetailEntiy) {
        viewController?.navigationController?.pushViewController(DetailBuilder.create(entity: entity), animated: true)
    }
}

