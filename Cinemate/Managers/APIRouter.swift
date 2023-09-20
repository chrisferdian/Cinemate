//
//  APIRouter.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import Foundation
enum APIRouter {
    static let baseURL = "https://api.themoviedb.org/3/"
    case discover(page: Int)
    
    var path: String {
        switch self {
        case .discover:
            return "discover/movie"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .discover(let page):
            return [
                "page": page,
//                "page_size": 10,
//                "key": "f5335289a413419ba2d3e6cf79dbc219"
            ]
        }
    }
}
