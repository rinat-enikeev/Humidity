//
//  HumidityTests.swift
//  HumidityTests
//
//  Created by Rinat Enikeev on 7/16/19.
//  Copyright © 2019 Rinat Enikeev. All rights reserved.
//

import XCTest
@testable import Humidity
typealias Humidity = Measurement<UnitHumidity>

class HumidityTests: XCTestCase {

    struct Constants {
        static let rH = 0.472
        static let temp = Measurement<UnitTemperature>(value: 24.9, unit: .celsius)
        static let dewPoint = 12.892023386545409
        static let abs = 10.812216095573042 // g/m3
    }

    func testAbsoluteToRelative() {
        let abs = Humidity(value: Constants.abs, unit: .absolute)
        XCTAssertEqual(abs.converted(to: .relative(temperature: Constants.temp)).value, Constants.rH)
    }

    func testRelativeToAbsolute() {
        let rh = Humidity(value: Constants.rH, unit: .relative(temperature: Constants.temp))
        XCTAssertEqual(rh.converted(to: .absolute).value, Constants.abs)
    }

    func testRelativeToDewPoint() {
        let rh = Humidity(value: Constants.rH, unit: .relative(temperature: Constants.temp))
        XCTAssertEqual(try rh.dewPoint(temperature: Constants.temp).value, Constants.dewPoint)
    }

    func testAbsoluteToDewPoint() {
        let abs = Humidity(value: Constants.abs, unit: .absolute)
        XCTAssertEqual(try abs.dewPoint(temperature: Constants.temp).value, Constants.dewPoint)
    }

    func testHumidityFormatterForAbsoluteValueShortEn() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "10.81g/m³")
    }

    func testHumidityFormatterForAbsoluteValueShortFi() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.fi)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "10,81g/m³")
    }

    func testHumidityFormatterForAbsoluteValueShortSv() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.sv)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "10,81g/m³")
    }

    func testHumidityFormatterForAbsoluteValueShortRu() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "10,81гр/м³")
    }

    func testHumidityFormatterForAbsoluteValueMediumEn() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "10.81\(String.npsb)g/m³")
    }

    func testHumidityFormatterForAbsoluteValueMediumSv() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.sv)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "10,81\(String.npsb)g/m³")
    }

    func testHumidityFormatterForAbsoluteValueMediumFi() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.fi)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "10,81\(String.npsb)g/m³")
    }

    func testHumidityFormatterForAbsoluteValueMediumRu() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "10,81\(String.npsb)гр/м³")
    }

    func testHumidityFormatterForAbsoluteValueLongEn() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "10.81\(String.npsb)grams/cubic meter")
    }

    func testHumidityFormatterForAbsoluteValueLongSv() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.sv)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "10,81\(String.npsb)gram/kubikmeter")
    }

    func testHumidityFormatterForAbsoluteValueLongFi() {
        let value = Humidity(value: Constants.abs, unit: .absolute)
        HumiditySettings.setLanguage(.fi)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "10,81\(String.npsb)grammaa/kuutiometri")
    }

    func testHumidityFormatterForAbsoluteValueLongRuZero() {
        let value = Humidity(value: 0.0, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "0\(String.npsb)грамм/кубический метр")
    }

    func testHumidityFormatterForAbsoluteValueLongRuOne() {
        let value = Humidity(value: 1, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "1\(String.npsb)грамм/кубический метр")
    }
    
    func testHumidityFormatterForAbsoluteValueLongRuTwo() {
        let value = Humidity(value: 2.1, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "2,1\(String.npsb)грамм/кубический метр")
    }

    func testHumidityFormatterForAbsoluteValueLongRuMany() {
        let value = Humidity(value: 25, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25\(String.npsb)грамм/кубический метр")
    }
    
    func testHumidityFormatterForRelativeValueShortEnZero() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "0%")
    }
    
    func testHumidityFormatterForRelativeValueMediumEnZero() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "0\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongEnAny() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "0\(String.npsb)%")
    }
    
    func testHumidityFormatterForRelativeValueShortRuZero() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "0%")
    }
    
    func testHumidityFormatterForRelativeValueMediumRuZero() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "0\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongRuZero() {
        let value = Humidity(value: 0.0, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "0\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongRuOne() {
        let value = Humidity(value: 1, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "100\(String.npsb)%")
    }
    
    func testHumidityFormatterForRelativeValueLongRuTwo() {
        let value = Humidity(value: 0.22, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.numberFormatter.numberStyle = .percent
        formatter.numberFormatter.paddingCharacter = ""
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "22\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongRuMany() {
        let value = Humidity(value: 0.253, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25,3\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongSvMany() {
        let value = Humidity(value: 0.253, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.sv)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25,3\(String.npsb)%")
    }

    func testHumidityFormatterForRelativeValueLongFiMany() {
        let value = Humidity(value: 0.253, unit: .relative(temperature: .init(value: 15, unit: .celsius)))
        HumiditySettings.setLanguage(.fi)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25,3\(String.npsb)%")
    }
}
