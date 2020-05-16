//
//  HumidityTests.swift
//  HumidityTests
//
//  Created by Rinat Enikeev on 7/16/19.
//  Copyright © 2019 Rinat Enikeev. All rights reserved.
//

import XCTest
@testable import Humidity

class HumidityTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPws() {
        let humidity = Humidity(c: 40.0, rh: 0.5)
        print("============")
        print("\(humidity.Td ?? 0)")
        print("============")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testHumidityFormatterForAbsoluteValueShortEn() {
        let value = Measurement<UnitHumidity>.init(value: 25.4, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "25.4g/m³")
    }

    func testHumidityFormatterForAbsoluteValueShortRu() {
        let value = Measurement<UnitHumidity>.init(value: 25.4, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .short
        XCTAssertEqual(formatter.string(from: value), "25.4гр/м³")
    }

    func testHumidityFormatterForAbsoluteValueMediumEn() {
        let value = Measurement<UnitHumidity>.init(value: 25.4, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "25.4 g/m³")
    }

    func testHumidityFormatterForAbsoluteValueMediumRu() {
        let value = Measurement<UnitHumidity>.init(value: 25.4, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .medium
        XCTAssertEqual(formatter.string(from: value), "25.4 гр/м³")
    }

    func testHumidityFormatterForAbsoluteValueLongEn() {
        let value = Measurement<UnitHumidity>.init(value: 25.4, unit: .absolute)
        HumiditySettings.setLanguage(.en)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25.4 grams/cubic meter")
    }

    func testHumidityFormatterForAbsoluteValueLongRuZero() {
        let value = Measurement<UnitHumidity>.init(value: 0.0, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "0.0 грамм/кубический метр")
    }

    func testHumidityFormatterForAbsoluteValueLongRuOne() {
        let value = Measurement<UnitHumidity>.init(value: 1, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "1.0 грамм/кубический метр")
    }
    
    func testHumidityFormatterForAbsoluteValueLongRuTwo() {
        let value = Measurement<UnitHumidity>.init(value: 2.1, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "2.1 грамм/кубический метр")
    }

    func testHumidityFormatterForAbsoluteValueLongRuMany() {
        let value = Measurement<UnitHumidity>.init(value: 25, unit: .absolute)
        HumiditySettings.setLanguage(.ru)
        let formatter = HumidityFormatter()
        formatter.unitStyle = .long
        XCTAssertEqual(formatter.string(from: value), "25.0 грамм/кубический метр")
    }
}
