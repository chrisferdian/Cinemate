//
//  DetailPresenter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
protocol DetailPresenterInput {
    func viewdidLoad(entity: DetailEntiy)
}
protocol DetailPresenterOutput: AnyObject {
    func displayVideos(_ videos: [MovieVideo])
    func displayReviews(_ reviews: [MovieReview])
}

class DetailPresenter: DetailPresenterInput , DetailInteractorOutput {
    weak var view: DetailPresenterOutput?
    var interactor: DetailInteractorInput?
    
    func viewdidLoad(entity: DetailEntiy) {
        interactor?.fetchVideos(id: entity.movie.id)
        interactor?.fetchReviews(id: entity.movie.id)
    }
    
    func didFetchVideos(_ list: [MovieVideo]) {
        view?.displayVideos(list)
    }
    
    func didFailToFetchVideos(withError error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchReviews(_ list: [MovieReview]) {
        view?.displayReviews(list)
    }
    
    func didFailToFetchReviews(withError error: Error) {
        
    }
}
