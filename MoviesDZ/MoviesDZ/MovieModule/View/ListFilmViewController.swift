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

    var moviePresenter: MovieViewPresenterProtocol?
    
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
        moviePresenter?.receiveMovieList()
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
        moviePresenter?.arrayListFilms?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: listFilmTableViewCellID, for: indexPath) as? ListFilmTableViewCell
        else { return UITableViewCell() }
        cell.setupView(result: moviePresenter?.arrayListFilms?.results[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailFilmViewController()
        let network = NetworkService()
        let detailVCPresenter = DetailMoviePresenter(view: detailVC, networkService: network)
        guard let movie = moviePresenter?.arrayListFilms?.results[indexPath.row].id else { return }
        detailVCPresenter.movieId = movie
        detailVC.presenter = detailVCPresenter
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ListFilmViewController: MovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.filmTableView.reloadData()
        }
    }
}
