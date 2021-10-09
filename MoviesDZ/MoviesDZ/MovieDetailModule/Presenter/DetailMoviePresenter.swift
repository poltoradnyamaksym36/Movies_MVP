// DetailMoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

//input на вход из Presentera во View
protocol MovieDetailViewProtocol: AnyObject{
    func reloadData()
}

//output логика и работа с Моделью
protocol DetailViewPresenterProtocol: AnyObject{
    var movieId: Int? {get set}
    func receiveMovieDetails()
    func receiveMovieDetailImage(cell: SelectedMovieImageTableViewCell )
}

final class DetailMoviePresenter: DetailViewPresenterProtocol {
    
    private let networkService: NetworkService?
    private var view: MovieDetailViewProtocol?
    var movieId: Int?
    var elements: Movie?
    
    init(view: MovieDetailViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func receiveMovieDetails() {
        networkService?.getFilmDetails(movieID: movieId, completion: { [weak self] elements in
            if elements != nil {
                self?.elements = elements
                self?.view?.reloadData()
            }
        })
    }
    
    func receiveMovieDetailImage(cell: SelectedMovieImageTableViewCell) {
        networkService?.receiveImage(posterPath: elements?.posterPath, completion: { [weak self] image in
            cell.chosenMoviePosterImageView.image = image
            self?.view?.reloadData()
        })
    }

}
