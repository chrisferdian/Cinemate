//
//  ReviewsPresenter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation

protocol ReviewsPresenterInput {
    func viewdidLoad(entity: DetailEntiy)
    func loadMoreData(id: Int)
}

protocol ReviewsPresenterOutput: AnyObject {
    func displayReviews(with list: [MovieReview])
    func displayLoadingIndicator(_ isVisible: Bool)
    
}

class ReviewsPresenter: ReviewsPresenterInput, ReviewsInteractorOutput {
    weak var view: ReviewsPresenterOutput?
    var interactor: ReviewsInteractorInput?
    var currentPage = 1
    private var isLoadingMoreData = false

    func viewdidLoad(entity: DetailEntiy) {
        interactor?.fetchReviews(id: entity.movie.id, page: currentPage)
    }
    
    func didFetchReviews(_ list: [MovieReview]) {
        view?.displayLoadingIndicator(false)
        view?.displayReviews(with: list)
        isLoadingMoreData = false
        currentPage += 1
    }
    
    func didFailToFetchReviews(withError error: Error) {
        view?.displayLoadingIndicator(false)
        isLoadingMoreData = false
    }
    
    func loadMoreData(id: Int) {
        fetchReviews(id: id)
    }
    private func fetchReviews(id: Int) {
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
        interactor?.fetchReviews(id: id, page: currentPage)
    }
}
