//
//  HumidityFormatter.swift
//  Humidity
//
//  Created by Viik.ufa on 16.05.2020.
//  Copyright © 2020 Rinat Enikeev. All rights reserved.
//

import Foundation

extension HumidityFormatter {
    public enum Unit : Int {
        case gramPerMeterCubic
        case relative
    }
}
open class HumidityFormatter: Formatter {
    /*@NSCopying*/ open var numberFormatter: NumberFormatter! // default is NumberFormatter with NumberFormatter.Style.decimal
    /*@NSCopying*/ open var locale: Locale!
    open var unitStyle: UnitStyle // default is Formatting.UnitStyle.medium

    public override init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        unitStyle = .medium
        locale = Locale.current
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        unitStyle = .medium
        locale = Locale.current
        super.init(coder:coder)
    }

    public func string(from value: Measurement<UnitHumidity>) -> String {
        return string(from: value.value, unitHumidity: value.unit)
    }

    private func formatString(for unit: Unit) -> String {
        switch unitStyle {
        case .short, .medium:
            return shortSymbol[unit]!
        case .long:
            return plural[unit]!
        @unknown default:
            return shortSymbol[unit]!
        }
    }

    private func string(from value: Double, unitHumidity: UnitHumidity) -> String {
        return string(fromValue: value, unit: unit(from: unitHumidity))
    }

    // Format a combination of a number and an unit to a localized string.
    private func string(fromValue value: Double, unit: HumidityFormatter.Unit) -> String {
        guard let formattedValue = numberFormatter.string(from:NSNumber(value: value)) else {
            fatalError("Cannot format \(value) as string")
        }
        let separator = unitStyle == .short ? "" : " "
        return String.localizedStringWithFormat(formatString(for: unit), value ,"\(formattedValue)\(separator)")
    }

    private func unit(from unitHumidity: UnitHumidity) -> Unit {
        var unit: Unit
        switch unitHumidity.symbol {
        case UnitHumidity.Symbol.absolute:
            unit = .gramPerMeterCubic
        case UnitHumidity.Symbol.relative:
            unit = .relative
        default:
            fatalError()
        }
        return unit
    }

    private static let bundle: Bundle = Bundle(path: Bundle(for: HumidityFormatter.self).path(forResource: "Humidity", ofType: "bundle")!) ?? Bundle.main

    private let shortSymbol: [Unit: String] = [
        .gramPerMeterCubic: NSLocalizedString("%f g per c m %@", bundle: HumidityFormatter.bundle, comment: ""),
        .relative: NSLocalizedString("%f percent symbol %@", bundle: HumidityFormatter.bundle, comment: "")
    ]

    private let plural: [Unit: String] = [
        .gramPerMeterCubic: NSLocalizedString("%f grams per cubic meter %@", bundle: HumidityFormatter.bundle, comment: ""),
        .relative: NSLocalizedString("%f percent %@", bundle: HumidityFormatter.bundle, comment: "")
    ]
}
