//
//  MoviesDZUITests.swift
//  MoviesDZUITests
//
//  Created by Max Inedom on 10/11/21.
//

import XCTest

class MoviesDZUITests: XCTestCase {

    var application: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }
}
