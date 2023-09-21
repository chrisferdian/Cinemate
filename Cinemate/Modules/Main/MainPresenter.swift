//
//  MainPresenter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 20/09/23.
//

import Foundation
protocol MainPresenterInput {
    func viewDidLoad()
    func loadMoreData()
    func didTapGenres()
    func didTapMovie(movie: Movie)
}

protocol MainPresenterOutput: AnyObject {
    func displayMovies(_ movies: [Movie])
    func displayLoadingIndicator(_ isVisible: Bool)
    func displayError(_ message: String)
    func displayGenreName(_ title: String)
    func removeExistingMovies()
}

class MainPresenter: MainPresenterInput, MainInteractorOutput {
    weak var view: MainPresenterOutput?
    var interactor: MainInteractorInput?
    var router: MainRouter?
    var currentPage = 1
    private var isLoadingMoreData = false

    func viewDidLoad() {
        fetchMovies()
    }

    func fetchMovies() {
        guard !isLoadingMoreData else {
            return
        }
        if let _totalPages = interactor?.totalPages {
            if currentPage > _totalPages {
                return
            }
        }
        isLoadingMoreData = true
        view?.displayLoadingIndicator(true)
        interactor?.fetchMovies(page: currentPage)
    }

    func loadMoreData() {
        fetchMovies()
    }

    func didFetchMovies(_ movies: [Movie]) {
        view?.displayLoadingIndicator(false)
        view?.displayMovies(movies)
        isLoadingMoreData = false
        currentPage += 1
    }

    func didFailToFetchMovies(withError error: Error) {
        view?.displayLoadingIndicator(false)
        view?.displayError(error.localizedDescription)
        isLoadingMoreData = false
    }
    
    func didTapGenres() {
        router?.navigateToGenres(pickerDelegate: self)
    }
    
    func didTapMovie(movie: Movie) {
        router?.navigateToDetail(entity: movie.toDetail())
    }
}

extension MainPresenter: IDataPickerDelegate {
    func didDataPicker(_ data: [String : Any]) {
        if let genre = data["genre"] as? GenreInfo {
            self.interactor?.genre = genre
            self.currentPage = 1
            self.view?.displayGenreName(genre.name)
            self.view?.removeExistingMovies()
            viewDidLoad()
            
        }
    }
}
