// MoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol MovieViewProtocol: AnyObject {
    func reloadData()
}

protocol MovieViewPresenterProtocol: AnyObject {
    var arrayListFilms: ListFilm? { get set }
    func receiveMovieList()
    func tapOnMovieCell(movieId: Int)
}

final class MoviePresenter: MovieViewPresenterProtocol {

    
    var arrayListFilms: ListFilm?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    weak var view: MovieViewProtocol?

    init(view: MovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func receiveMovieList() {
        networkService?.getFilms { [weak self] elements in
            if elements != nil {
                self?.arrayListFilms = elements
                self?.view?.reloadData()
            }
        }
    }
    func tapOnMovieCell(movieId: Int) {
        router?.showFilmDetail(movieId: movieId)
    }
    
}
