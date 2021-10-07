// NetworkService.swift
// Copyright © VTB. All rights reserved.

import Foundation
import Alamofire
import UIKit

protocol NetworkServiceProtocol {
    func getFilms(completion: @escaping (ListFilm?) -> Void)
    func getFilmDetails(movieID: Int?, completion: @escaping (Movie?) -> Void)
    func receiveImage(posterPath: String?, completion: @escaping (UIImage?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func receiveImage(posterPath: String?, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard
                let posterPath = posterPath,
                let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)"),
                let imageInformation = try? Data(contentsOf: url),
                let posterImage = UIImage(data: imageInformation) else { return }
            DispatchQueue.main.async {
                completion(posterImage)
            }
        }
    }
    
    func getFilms(completion: @escaping (ListFilm?) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=8a8ef26b18b57682681f9e71bfc3d836&language=ru-RU&page=1"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).responseData { responce in
            guard let data = responce.data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(ListFilm.self, from: data)
                completion(movie)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    func getFilmDetails(movieID: Int?, completion: @escaping (Movie?) -> Void) {
        guard let movieID = movieID else { return }
        let urlString = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).responseData { responce in
            guard let data = responce.data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let detailFilm = try decoder.decode(Movie.self, from: data)
                completion(detailFilm)
            } catch {
                completion(nil)
            }
        }
    }
}



