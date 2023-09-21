//
//  DetailEntity.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation

struct DetailEntiy {
    var movie: Movie
}

struct MovieVideoResponse: Codable {
    let id: Int
    let results: [MovieVideo]
}

// MARK: - Result
struct MovieVideo: Codable, Hashable {
    let name, key, site: String?
    let size: Int?
    let type: String?
    let official: Bool
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

struct MovieTitles: Hashable {
    var title: String
    var release_date: String
    var vote_average: Float
}
struct MovieOverview: Hashable {
    var text: String
}
