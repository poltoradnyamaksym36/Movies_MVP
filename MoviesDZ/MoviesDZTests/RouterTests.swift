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


class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = ModelBuilder()

    override func setUp() {
        router = Router(navigationController: navigationController, builder: assembly)
    }

    override func tearDown() {
        router = nil
    }

    func testRouterPush() {
        router.showFilmDetail(movieId: 2)
        let detailMovieVc = navigationController.presntedVc
        XCTAssertTrue(detailMovieVc is DetailFilmViewController)
    }
}
