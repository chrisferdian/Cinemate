//
//  PreferencesEntity.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 22/09/23.
//

import Foundation
enum UserPreferenceSettings: CaseIterable {
    case isAdultContent
    
    var title: String {
        switch self {
        case .isAdultContent:
            return "Include adult contents"
        }
    }
    
    var value: Any {
        switch self {
        case .isAdultContent:
            return UserPreference.isAdult
        }
    }
}
struct PreferencesEntity {
    
}
