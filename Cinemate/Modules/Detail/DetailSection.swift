//
//  DetailSection.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import Foundation
enum DetailSection {
    case backdrop
    case title
    case headerVideos
    case description
    case suggestion
    case reviews
    case credits
    
    var sectionTitle: String {
        switch self {
        case .credits: return "Credits"
        case .reviews: return "Reviews"
        case .suggestion: return "Similer Movies"
        default: return ""
        }
    }
}
