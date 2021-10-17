// MoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol MovieViewProtocol: AnyObject {
    func reloadData()
}

protocol MovieViewPresenterProtocol: AnyObject {
    var arrayListFilms: [CoreMovieObject]? { get set }
    func receiveMovieList()
    func tapOnMovieCell(movieId: Int)
}

final class MoviePresenter: MovieViewPresenterProtocol {
    var arrayListFilms: [CoreMovieObject]?
    let networkService: NetworkServiceProtocol?
    var router: RouterProtocol?
    var dataStorage: DataStorageServiceProtocol
    weak var view: MovieViewProtocol?

    init(view: MovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, dataStorage: DataStorageServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.dataStorage = dataStorage
    }
        
    func receiveMovieList() {
        networkService?.getFilms { (resuls, error) in
            if error != nil {
                return
            }
            self.dataStorage.save(object: resuls.results)
            self.arrayListFilms = self.dataStorage.get()
            self.view?.reloadData()
        }
    }
    
    func tapOnMovieCell(movieId: Int) {
        router?.showFilmDetail(movieId: movieId)
    }
    
}
