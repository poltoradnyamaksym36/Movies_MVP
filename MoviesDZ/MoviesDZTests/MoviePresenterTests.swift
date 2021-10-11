//
//  MoviePresenterTests.swift
//  MoviesDZTests
//
//  Created by Max Inedom on 10/11/21.
//

@testable import MoviesDZ
import XCTest


final class MovieMockView: MovieViewProtocol {
    func reloadData() {
    }
    
    func success() {}
}

final class MockNetworkService: NetworkServiceProtocol {
    var movies: ListFilm?
    var movie: Movie?
    var posterPath: ListFilm?
    init() {}

    convenience init(movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    convenience init(movies: ListFilm) {
        self.init()
        self.movies = movies
    }
    
    func getFilms(completion: @escaping (ListFilm?) -> Void) {
        if let movies = movies {
            completion(movies)
        } else {
            let error = NSError(domain: "", code: 500, userInfo: nil)
            print(error)
            completion(nil)
        }
    }
    
    func getFilmDetails(movieID: Int?, completion: @escaping (Movie?) -> Void) {
        if let movie = movie {
            completion(movie)
        } else {
            let error = NSError(domain: "", code: 500, userInfo: nil)
            print(error)
            completion(nil)
        }
    }
    
    func receiveImage(posterPath: String?, completion: @escaping (UIImage) -> Void) {
        if let poster = posterPath {
            completion(UIImage(named: poster) ?? UIImage())
        } else {
            let error = NSError(domain: "", code: 500, userInfo: nil)
            print(error)
        }
    }
}

final class MockImageService: NetworkServiceProtocol {
    func getFilms(completion: @escaping (ListFilm?) -> Void) {}
}
    

final class MockDataStorageSerervice: Dat
    func getFilmDetails(movieID: Int?, completion: @escaping (Movie?) -> Void) {
        <#code#>
    }
    
    func receiveImage(posterPath: String?, completion: @escaping (UIImage) -> Void) {
        <#code#>
    }
    
    func getImage(url _: URL, completion _: @escaping (UIImage) -> Void) {
        
    }
}
