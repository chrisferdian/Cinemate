//
//  DetailInteractor.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation

protocol DetailInteractorInput {
    func fetchVideos(id: Int)
    func fetchReviews(id: Int)
    func fetchSimilerMovies(id: Int)
    func fetchCredits(id: Int)
}
protocol DetailInteractorOutput: AnyObject {
    func didFetchVideos(_ list: [MovieVideo])
    func didFailToFetchVideos(withError error: Error)
    
    func didFetchReviews(_ list: [MovieReview])
    func didFailToFetchReviews(withError error: Error)
    
    func didFetchSimilers(_ list: [Movie])
    func didFailToFetchSimilers(withError error: Error)
    
    func didFetchCredits(_ list: [CastMovie])
    func didFailToFetchCredits(withError error: Error)
}

class DetailInteractor: DetailInteractorInput {
    
    weak var output: DetailInteractorOutput?

    func fetchVideos(id: Int) {
        NetworkingManager.shared.request(.videos(id: id), method: .get) { [weak self] (result: Result<MovieVideoResponse, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchVideos(success.results)
            case .failure(let failure):
                self?.output?.didFailToFetchVideos(withError: failure)
            }
        }
    }
    
    func fetchReviews(id: Int) {
        NetworkingManager.shared.request(.reviews(id: id, page: 1), method: .get) { [weak self] (result: Result<ReviewResponse, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchReviews(success.results ?? [])
            case .failure(let failure):
                self?.output?.didFailToFetchReviews(withError: failure)
            }
        }
    }
    
    func fetchSimilerMovies(id: Int) {
        NetworkingManager.shared.request(.similer(id: id), method: .get) { [weak self] (result: Result<MainEntity.Response, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchSimilers(success.results)
            case .failure(let failure):
                self?.output?.didFailToFetchSimilers(withError: failure)
            }
        }
    }
    
    func fetchCredits(id: Int) {
        NetworkingManager.shared.request(.credits(id: id), method: .get) { [weak self] (result: Result<CreditResponse, Error>) in
            switch result {
            case .success(let success):
                self?.output?.didFetchCredits(success.cast ?? [])
            case .failure(let failure):
                self?.output?.didFailToFetchCredits(withError: failure)
            }
        }
    }
}
