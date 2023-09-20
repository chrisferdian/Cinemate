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
    var poster_path: String?
}
