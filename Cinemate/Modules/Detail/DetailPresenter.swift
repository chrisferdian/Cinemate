//
//  DetailPresenter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
protocol DetailPresenterInput {
    func viewdidLoad(entity: DetailEntiy)
    func presentReviews(entity: DetailEntiy)
}
protocol DetailPresenterOutput: AnyObject {
    func displayVideos(_ videos: [MovieVideo])
    func displayReviews(_ reviews: [MovieReview])
    func displayNullReviews()
    
    func displaySimilerMovies(_ list: [Movie])
    func displayCredits(cast: [CastMovie])
}

class DetailPresenter: DetailPresenterInput , DetailInteractorOutput {
    weak var view: DetailPresenterOutput?
    var interactor: DetailInteractorInput?
    var router: DetailRouter?

    func viewdidLoad(entity: DetailEntiy) {
        interactor?.fetchVideos(id: entity.movie.id)
        interactor?.fetchReviews(id: entity.movie.id)
        interactor?.fetchSimilerMovies(id: entity.movie.id)
        interactor?.fetchCredits(id: entity.movie.id)
    }
    
    func didFetchVideos(_ list: [MovieVideo]) {
        view?.displayVideos(list)
    }
    
    func didFailToFetchVideos(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchReviews(_ list: [MovieReview]) {
        if list.isEmpty {
            view?.displayNullReviews()
            return
        }
        view?.displayReviews(list)
    }
    
    func didFailToFetchReviews(withError error: Error) {
        view?.displayNullReviews()
    }
    
    func presentReviews(entity: DetailEntiy) {
        router?.navigateToReviews(entity: entity)
    }
    
    func didFetchSimilers(_ list: [Movie]) {
        view?.displaySimilerMovies(list)
    }
    
    func didFailToFetchSimilers(withError error: Error) {
        
    }
    
    func didFetchCredits(_ list: [CastMovie]) {
        view?.displayCredits(cast: list.filter({ $0.known_for_department?.lowercased() == "acting" }))
    }
    
    func didFailToFetchCredits(withError error: Error) {
        
    }
}
