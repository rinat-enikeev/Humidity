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
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        unitStyle = .medium
        locale = Locale.current
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
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
        if unit == .relative {
            return percentString(forValue: value)
        } else {
            return decimalString(forValue: value)
        }
    }

    private func decimalString(forValue value: Double) -> String {
        numberFormatter.numberStyle = .decimal
        let separator = unitStyle == .short ? "" : " "
        guard let formattedValue = numberFormatter.string(from:NSNumber(value: value)) else {
            fatalError("Cannot format \(value) as string")
        }
        return String.localizedStringWithFormat(formatString(for: .gramPerMeterCubic), value ,"\(formattedValue)\(separator)")
    }

    private func percentString(forValue value: Double) -> String {
        numberFormatter.numberStyle = .percent
        let separator = unitStyle == .short ? "" : " "
        guard let formattedValue = numberFormatter.string(from:NSNumber(value: value)) else {
            fatalError("Cannot format \(value) as string")
        }
        return formattedValue
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "%", with: "\(separator)%")
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

    private let shortSymbol: [Unit: String] = [
        .gramPerMeterCubic: NSLocalizedString("%f g per c m %@", bundle: HumiditySettings.bundle, comment: "")
    ]

    private let plural: [Unit: String] = [
        .gramPerMeterCubic: NSLocalizedString("%f grams per cubic meter %@", bundle: HumiditySettings.bundle, comment: ""),
    ]
}
