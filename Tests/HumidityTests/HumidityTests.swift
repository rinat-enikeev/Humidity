import XCTest
@testable import Humidity

final class HumidityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Humidity().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
