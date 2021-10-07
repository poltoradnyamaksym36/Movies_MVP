// MoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol MovieViewProtocol: AnyObject {
    func reloadData()
}

protocol MovieViewPresenterProtocol: AnyObject {
    var arrayListFilms: ListFilm? { get set }
    func receiveMovieList()
}

final class MoviePresenter: MovieViewPresenterProtocol {

    var arrayListFilms: ListFilm?
    let networkService: NetworkServiceProtocol!
    weak var view: MovieViewProtocol?

    init(view: MovieViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func receiveMovieList() {
        networkService.getFilms { [weak self] elements in
            if elements != nil {
                self?.arrayListFilms = elements
                self?.view?.reloadData()
            }
        }
    }
    
}
