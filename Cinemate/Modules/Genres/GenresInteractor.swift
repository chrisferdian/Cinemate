//
//  GenresInteractor.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
protocol GenresInteractorInput {
    func fetchGenreList()
}
protocol GenresInteractorOutput: AnyObject {
    func didFetchGenres(_ list: [GenreInfo])
    func didFailToFetchGenres(withError error: Error)
}

class GenresInteractor: GenresInteractorInput {
    weak var output: GenresInteractorOutput?
    
    func fetchGenreList() {
        NetworkingManager.shared.request(.genres, method: .get) { [weak self] (result: Result<GenresEntity.Response, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchGenres(success.genres)
            case .failure(let failure):
                self?.output?.didFailToFetchGenres(withError: failure)
            }
        }
    }
}
