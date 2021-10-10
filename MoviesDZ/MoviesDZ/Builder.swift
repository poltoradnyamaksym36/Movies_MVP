//
//  Builder.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/9/21.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func createListFilmModule(router: RouterProtocol) -> UIViewController
    func createFilmDetails(router: RouterProtocol, movieId: Int) -> UIViewController
}

class ModelBuilder: BuilderProtocol {
    func createListFilmModule(router: RouterProtocol) -> UIViewController {
        let filmView = ListFilmViewController()
        let networkService = NetworkService()
        let dataStorageService = DataStorageService()
        let presenter = MoviePresenter(view: filmView, networkService: networkService, router: router, dataStorage: dataStorageService)
        filmView.presenter = presenter
        return filmView
    }
    
    func createFilmDetails(router: RouterProtocol, movieId: Int) -> UIViewController {
        let detailFilmView = DetailFilmViewController()
        let networkService = NetworkService()
        let presenter = MovieDetailPresenter(view: detailFilmView, networkService: networkService, router: router, movieId: movieId)
        detailFilmView.presenter = presenter
        return detailFilmView
    }
}
