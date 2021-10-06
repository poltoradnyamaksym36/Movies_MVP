// MoviePresenter.swift
// Copyright © VTB. All rights reserved.

import Foundation

protocol MovieViewProtocol {
    func reloadData()
}

protocol MoviewViewPresenterProtocol {
    var arrayListFilms: ListFilm? { get set }
}

final class MoviePresenter: MoviewViewPresenterProtocol {
    let view: MovieViewProtocol
    var arrayListFilms: ListFilm?

    init(view: MovieViewProtocol) {
        self.view = view
        fetchData()
    }

    private func fetchData() {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/popular?api_key=8a8ef26b18b57682681f9e71bfc3d836&language=ru-RU&page=1"
            )
        else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let decodeData = try JSONDecoder().decode(ListFilm.self, from: data)
                self.arrayListFilms = decodeData
                self.view.reloadData()
            } catch {
                print("Error", error.localizedDescription)
            }
        }.resume()
    }
}
