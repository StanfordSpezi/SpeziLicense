//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import XCTest


class TestAppUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
    }
    

    @MainActor
    func testSpeziLicense() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 2.0))

        XCTAssertTrue(app.staticTexts["This project is licensed under the MIT License."].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["The following list contains all Swift Package dependencies of the TestApp app."].exists)
        XCTAssertTrue(app.buttons["Repository Link"].exists)
        XCTAssertTrue(app.staticTexts["Spezi"].exists)
    }
}
