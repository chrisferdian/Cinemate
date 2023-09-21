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

// MARK: - Welcome
struct ReviewResponse: Codable {
    let id, page: Int?
    let results: [MovieReview]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieReview: Codable, Hashable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable, Hashable {
    let name, username: String?
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}


// MARK: - Credits
struct CreditResponse: Codable {
    let cast, crew: [CastMovie]?
}

struct CastMovie: Codable, Hashable {
    var known_for_department: String?
    var name: String?
    var profile_path: String?
    var character: String?
}
