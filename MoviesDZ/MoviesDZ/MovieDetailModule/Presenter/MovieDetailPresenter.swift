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
    func receiveMovieDetailImage(cell: SelectedMovieImageTableViewCell)
}

final class MovieDetailPresenter: DetailViewPresenterProtocol {
    private let networkService: NetworkService?
    private var view: MovieDetailViewProtocol?
    var arrayListFilms: [CoreDescriptionObject]?
    var movieId: Int?
    var router: RouterProtocol?
    var dataStorageService: DataStorageServiceProtocol
    var movieDetails: Movie?
    
    init(view: MovieDetailViewProtocol, networkService: NetworkService, router: RouterProtocol, movieId: Int, dataStorageService: DataStorageServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.movieId = movieId
        self.dataStorageService = dataStorageService
    }
    
    func receiveMovieDetails() {
        networkService?.getFilmDetails(movieID: movieId, completion: { (movieDetail, error) in
            if error != nil {
                print(error?.localizedDescription)
               return
            }
            self.movieDetails = movieDetail
            self.view?.reloadData()
        })
    }
    
    func receiveMovieDetailImage(cell: SelectedMovieImageTableViewCell) {
        networkService?.receiveImage(posterPath: movieDetails?.posterPath, completion: { [weak self] image in
            cell.chosenMoviePosterImageView.image = image
            self?.view?.reloadData()
        })
    }

}
