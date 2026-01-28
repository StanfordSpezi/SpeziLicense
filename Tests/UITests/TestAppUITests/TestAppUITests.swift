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

        XCTAssertTrue(app.buttons["TestApp, MIT, Version: 1.0"].waitForExistence(timeout: 2))
        let speziButton = app.buttons.matching(NSPredicate(
            format: "label LIKE 'Spezi, MIT, Version: 1.*.*'"
        )).element
        XCTAssertTrue(speziButton.exists)
        speziButton.tap()
        
        sleep(1)
        print(app.debugDescription)
        let licensePred = NSPredicate(
            format: "label CONTAINS 'Copyright (c) 2022 Stanford University and the project authors (see CONTRIBUTORS.md)'"
        )
        XCTAssert(app.staticTexts.matching(licensePred).element.exists)
        app.navigationBars.buttons["Open in Browser"].tap()
        
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        XCTAssert(
            safari.staticTexts[
                "Open-source framework for rapid development of modern, interoperable digital health applications."
            ].waitForExistence(timeout: 20) // swiftlint:disable:this multiline_function_chains
        )
    }
}
