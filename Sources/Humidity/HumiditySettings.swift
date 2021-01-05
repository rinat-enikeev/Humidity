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
        case sv
        case fi

        var locale: Locale {
            switch self {
            case .en:
                return Locale(identifier: "en_US")
            case .ru:
                return Locale(identifier: "ru_RU")
            case .fi:
                return Locale(identifier: "fi")
            case .sv:
                return Locale(identifier: "sv")
            }
        }
    }

    @UserDefault("HumiditySettings.Language", defaultValue: Language.en.rawValue)
    fileprivate static var language: String

    static var bundle: Bundle {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            var path = Bundle(for: HumidityFormatter.self).path(forResource: HumiditySettings.language, ofType: "lproj")
            #if SWIFT_PACKAGE
            if path == nil {
                path = Bundle.module.path(forResource: "\(HumiditySettings.language)", ofType: "lproj")
            }
            #else
            if path == nil {
                path = Bundle(for: HumidityFormatter.self).path(forResource: "Resources/\(HumiditySettings.language)", ofType: "lproj")
            }
            #endif
            if path == nil {
                guard let testPath = Bundle(for: HumidityFormatter.self).path(forResource: "Humidity.bundle/\(HumiditySettings.language)", ofType: "lproj") else {
                    return Bundle.main
                }
                return Bundle(path: testPath) ?? Bundle.main
            }
            return Bundle(path: path!) ?? Bundle.main
        } else {
            var path = Bundle(for: HumidityFormatter.self).path(forResource: "Humidity.bundle/\(HumiditySettings.language)", ofType: "lproj")
            #if SWIFT_PACKAGE
            if path == nil {
                path = Bundle.module.path(forResource: "\(HumiditySettings.language)", ofType: "lproj")
            }
            #else
            if path == nil {
                path = Bundle(for: HumidityFormatter.self).path(forResource: "Resources/\(HumiditySettings.language)", ofType: "lproj")
            }
            #endif
            if path == nil {
                return Bundle.main
            }
            return Bundle(path: path!) ?? Bundle.main
        }
    }

    public static func setLanguage(_ language: Language) {
        HumiditySettings.language = language.rawValue
    }

    static var locale: Locale {
        return Language(rawValue: language)?.locale ?? Locale.current
    }
}
