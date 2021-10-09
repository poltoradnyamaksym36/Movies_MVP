//
//  MoviesDZTests.swift
//  MoviesDZTests
//
//  Created by Max Inedom on 10/9/21.
//

@testable import MoviesDZ
import XCTest

final class MockNavigationController: UINavigationController {
    var presntedVc: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presntedVc = viewController
        super.pushViewController(viewController, animated: true)
    }

    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> ())? = nil
    ) {
        presntedVc = viewControllerToPresent
        super.present(viewControllerToPresent, animated: true)
    }
}


class MoviesDZTests: XCTestCase {

    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = ModelBuilder()
    
    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, builder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouterPush() {
        router.showFilmDetail(movieId: 1)
        let detailMovieViewController = navigationController.presntedVc
        XCTAssertTrue(detailMovieViewController is DetailFilmViewController)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
