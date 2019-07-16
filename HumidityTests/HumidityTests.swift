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
        let humidity = Humidity(celsius: 10.0)
        print("============")
        print("\(humidity.Pws())")
        print("============")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
