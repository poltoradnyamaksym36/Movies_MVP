// DetailMoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

final class DetailMoviePresenter {
    var view: DetailFilmViewController?
    var movieList: Movie?

    public func setMovieDetail() {}

    init(id: Int) {
        fetchFill(id: id)
    }

    private func fetchFill(id: Int) {
        guard let url =
            URL(
                string: """
                https://api.themoviedb.org/3/movie/\(id)?api_key=7502b719af3e4c9ad68d80658e7b83ed&language=ru-RU
                """
            )
        else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                self.movieList = try JSONDecoder()
                    .decode(Movie.self, from: data ?? Data())
                print(self.movieList)
                DispatchQueue.main.async {
                    print("reloadData")
                    self.view?.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
