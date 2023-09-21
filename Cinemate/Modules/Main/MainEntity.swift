//
//  MainEntity.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import Foundation

struct MainEntity {
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    
    struct Response: Codable {
        var page: Int
        var total_pages: Int
        var results: [Movie]
    }
}


struct Movie: Codable, Hashable {
    var id: Int
    var poster_path: String?
    var backdrop_path: String?
    var title: String?
    var release_date: String?
    var vote_average: Float?
    var overview: String?
}

extension Movie {
    func toDetail() -> DetailEntiy {
        return DetailEntiy(movie: self)
    }
    
    func toTitle() -> MovieTitles {
        return MovieTitles(title: title ?? "-", release_date: release_date ?? "-", vote_average: vote_average ?? 0)
    }
    
    func toOverview() -> MovieOverview {
        return MovieOverview(text: overview ?? "-")
    }
}
