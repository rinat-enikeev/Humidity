//
//  HumiditySettings.swift
//  Humidity
//
//  Created by Viik.ufa on 16.05.2020.
//  Copyright © 2020 Rinat Enikeev. All rights reserved.
//

import Foundation
public struct HumiditySettings {
    public enum Language: String {
        case en
        case ru
    }
    @UserDefault("HumiditySettings.Language", defaultValue: Language.en.rawValue)
    fileprivate static var language: String

    static var bundle: Bundle {
        return Bundle(path: Bundle(for: HumidityFormatter.self).path(forResource: HumiditySettings.language, ofType: "lproj")!) ?? Bundle.main
    }

    public static func setLanguage(_ language: Language) {
        HumiditySettings.language = language.rawValue
    }
}
