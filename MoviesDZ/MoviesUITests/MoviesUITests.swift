//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Max Inedom on 10/11/21.
//

import XCTest

class MoviesUITests: XCTestCase {
    var application: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }
    
    func testMovieTableView() {
        let movieTableView = application.tables["MovieTableView"]
        XCTAssertTrue(movieTableView.exists)
        XCTAssertTrue(movieTableView.isEnabled)
        XCTAssertTrue(movieTableView.isHittable)
        XCTAssertFalse(movieTableView.isSelected)
        movieTableView.swipeUp()
        movieTableView.swipeDown()
    }
    
    func testCellMovieViewController() {
        let movieTableView = application.tables["MovieTableView"]
        let cell = movieTableView.cells["MovieTableViewCell"]
        XCTAssertTrue(cell.exists)
        XCTAssertTrue(cell.firstMatch.isHittable)
        cell.firstMatch.tap()
    }
    
    func testDetailMovieControllerTableView() {
        showDetailScreen()
        let tableView = application.tables["MovieDetalTableView"]
        tableView.swipeUp()
        tableView.swipeDown()
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(tableView.isEnabled)
    }
    
    func showDetailScreen() {
        let movieTableView = application.tables["MovieTableView"]
        let cell = movieTableView.cells["MovieTableViewCell"]
        cell.firstMatch.tap()
    }
    
}

