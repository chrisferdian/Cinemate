//
//  ReviewsInteractor.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
protocol ReviewsInteractorInput {
    func fetchReviews(id: Int, page: Int)
    var totalPages: Int? { get set }
}
protocol ReviewsInteractorOutput: AnyObject {
    func didFetchReviews(_ list: [MovieReview])
    func didFailToFetchReviews(withError error: Error)
}

class ReviewsInteractor: ReviewsInteractorInput {
    weak var output: ReviewsInteractorOutput?
    var totalPages: Int?

    func fetchReviews(id: Int, page: Int) {
        NetworkingManager.shared.request(.reviews(id: id, page: page), method: .get) { [weak self] (result: Result<ReviewResponse, Error>) in
            switch result {
            case .success(let success):
                self?.totalPages = success.totalPages
                self?.output?.didFetchReviews(success.results ?? [])
            case .failure(let failure):
                self?.output?.didFailToFetchReviews(withError: failure)
            }
        }
    }
}
