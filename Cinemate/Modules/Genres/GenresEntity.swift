//
//  GenresEntity.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
struct GenresEntity {
    struct Response: Codable {
        var genres: [GenreInfo]
    }
}

struct GenreInfo: Codable, Hashable {
    var id: Int
    var name: String
}
