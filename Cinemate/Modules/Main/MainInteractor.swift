//
//  MainInteractor.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 20/09/23.
//

import Foundation
protocol MainInteractorInput {
    func fetchMovies(page: Int)
    var totalPages: Int? { get set }
}

protocol MainInteractorOutput: AnyObject {
    func didFetchMovies(_ movies: [Movie])
    func didFailToFetchMovies(withError error: Error)
}

class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?
    var totalPages: Int?
    
    func fetchMovies(page: Int) {
        NetworkingManager.shared.request(.discover(page: page), method: .get) { [weak self] (result: Result<MainEntity.Response, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchMovies(success.results)
            case .failure(let failure):
                self?.output?.didFailToFetchMovies(withError: failure)
            }
        }
    }
}
