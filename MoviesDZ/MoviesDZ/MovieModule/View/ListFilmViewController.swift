// ListFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// FirstView
class ListFilmViewController: UIViewController {
    // MARK: Private Properties

    private var filmTableView = UITableView()
    private var arrayListFilms: [Results] = []
    private let listFilmTableViewCellID = ListFilmTableViewCell.identifier

    // MARK: - Public Properties

    var moviePresenter: MovieViewPresenterProtocol!
    var networkApiService: NetworkServiceProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(filmTableView)
        navigationItem.title = "Movies"

        filmTableView.translatesAutoresizingMaskIntoConstraints = false
        filmTableView.register(ListFilmTableViewCell.self, forCellReuseIdentifier: listFilmTableViewCellID)
        filmTableView.backgroundColor = .white
        filmTableView.dataSource = self
        filmTableView.delegate = self
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            filmTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filmTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filmTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ListFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviePresenter.arrayListFilms?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: listFilmTableViewCellID, for: indexPath) as? ListFilmTableViewCell
        else { return UITableViewCell() }

        
        cell.setupView(listFilm: moviePresenter.arrayListFilms?.results[indexPath.row])
        
        
//        DispatchQueue.global().async {
//
//            guard let poster = self.moviePresenter.arrayListFilms?.results[indexPath.row].posterPath else { return }
//
//            guard let urlImage =
//                URL(
//                    string: "https://image.tmdb.org/t/p/w500\(poster)"
//                )
//            else { return }
//            guard let imageData = try? Data(contentsOf: urlImage) else { return }
//            guard let image = UIImage(data: imageData) else { return }
//
//            DispatchQueue.main.async {
//                cell.movieImageView.image = image
//            }
//        }
        cell.labelText.text = moviePresenter.arrayListFilms?.results[indexPath.row].overview
        cell.titleLabel.text = moviePresenter.arrayListFilms?.results[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = moviePresenter.arrayListFilms?.results[indexPath.row].id else { return }
        let vc = DetailFilmViewController()
        let network = NetworkService()
        var presenterVC = DetailMoviePresenter(view: vc as! MovieDetailViewProtocol, networkService: network)
        vc.presenter = presenterVC
        presenterVC.view = vc as! MovieDetailViewProtocol
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListFilmViewController: MovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.filmTableView.reloadData()
        }
    }
}
