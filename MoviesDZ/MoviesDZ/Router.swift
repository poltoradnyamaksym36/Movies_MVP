//
//  Router.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/9/21.
//

import Foundation
import UIKit

protocol RouterMain {
    var navControl: UINavigationController? {get set}
    var builder: BuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func initialFilmViewController()
    func showFilmDetail(movieId: Int)
    func popToRoot()
}

class Router: RouterProtocol {
    var navControl: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navControl = navigationController
        self.builder = builder
    }
    
    func initialFilmViewController() {
        if let navigationController = navControl {
            guard let filmVC = builder?.createListFilmModule(router: self) else { return }
            navigationController.viewControllers = [filmVC]
        }
    }
    
    func showFilmDetail(movieId: Int) {
        if let navigationController = navControl {
            guard let detailFilmVC = builder?.createFilmDetails(router: self, movieId: movieId) else { return }
            navigationController.pushViewController(detailFilmVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navControl {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
