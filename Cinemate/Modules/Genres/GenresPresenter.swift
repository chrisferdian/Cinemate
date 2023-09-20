//
//  GenresPresenter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
protocol GenresPresenterInput {
    func viewDidload()
}
protocol GenresPresenterOutput: AnyObject {
    func displayGenres(_ genres: [GenreInfo])
    func displayLoadingIndicator(_ isVisible: Bool)
    func displayError(_ message: String)
}

class GenresPresenter: GenresPresenterInput, GenresInteractorOutput {
    
    weak var view: GenresPresenterOutput?
    var interactor: GenresInteractorInput?
    
    func viewDidload() {
        fetchGenres()
    }
    
    private func fetchGenres() {
        view?.displayLoadingIndicator(true)
        interactor?.fetchGenreList()
    }
    
    func didFetchGenres(_ list: [GenreInfo]) {
        view?.displayLoadingIndicator(false)
        view?.displayGenres(list)
    }
    
    func didFailToFetchGenres(withError error: Error) {
        view?.displayLoadingIndicator(false)
        view?.displayError(error.localizedDescription)
    }
}
