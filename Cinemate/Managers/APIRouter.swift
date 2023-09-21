//
//  APIRouter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import Foundation
enum APIRouter {
    static let baseURL = "https://api.themoviedb.org/3/"
    case discover(page: Int, genre: Int?)
    case genres
    case videos(id: Int)
    
    var path: String {
        switch self {
        case .discover:
            return "discover/movie"
        case .genres:
            return "genre/movie/list?language=en"
        case .videos(let id):
            return "movie/\(id)/videos?language=en-U"
        }
    }
    
    var parameters: [String: Any?]? {
        switch self {
        case .discover(let page, let genre):
            return [
                "page": page,
                "with_genres": genre
            ]
        default: return nil
        }
    }
}
