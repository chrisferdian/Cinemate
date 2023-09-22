//
//  UserDefaultsHelper.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 22/09/23.
//

import Foundation
import Foundation

struct PreferencesKeys {
    static let adult = "ADULT"
}

@propertyWrapper
struct Preference<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
struct UserPreference {
    @Preference(key: PreferencesKeys.adult, defaultValue: false)
    static var isAdult: Bool
}
