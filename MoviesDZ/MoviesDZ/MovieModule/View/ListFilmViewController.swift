// ListFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit
/// FirstView
class ListFilmViewController: UIViewController {
    
    // MARK: Private Properties
    private var filmTableView = UITableView()
    private let listFilmTableViewCellID = ListFilmTableViewCell.identifier
    var router: RouterProtocol?
    // MARK: - Public Properties

    var presenter: MovieViewPresenterProtocol?
    
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
        presenter?.receiveMovieList()
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
        presenter?.arrayListFilms?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: listFilmTableViewCellID, for: indexPath) as? ListFilmTableViewCell
        else { return UITableViewCell() }
        cell.setupView(result: presenter?.arrayListFilms?[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = presenter?.arrayListFilms?[indexPath.row].id else { return }
        router?.showFilmDetail(movieId: movieID)
    }
}

extension ListFilmViewController: MovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.filmTableView.reloadData()
        }
    }
}
