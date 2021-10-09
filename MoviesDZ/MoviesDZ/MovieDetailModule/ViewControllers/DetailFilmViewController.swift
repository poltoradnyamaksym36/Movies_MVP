// DetailFilmViewController.swift
// Copyright © VTB. All rights reserved.

import UIKit

final class DetailFilmViewController: UIViewController {
    var presenter: MovieDetailPresenter?
    var movieID: Int?

    // MARK: - Private Properties

    private let imageCellID = SelectedMovieImageTableViewCell.identifier
    private let descriptionCellID = DetailFilmTableViewCell.identifier

    private let chosenMovieTableView: UITableView = {
        let chosenMovieTableView = UITableView()
        chosenMovieTableView.translatesAutoresizingMaskIntoConstraints = false
        chosenMovieTableView.register(
            SelectedMovieImageTableViewCell.self,
            forCellReuseIdentifier: "SelectedMovieImageTableViewCell"
        )
        chosenMovieTableView.register(DetailFilmTableViewCell.self, forCellReuseIdentifier: "DetailFilmTableViewCell")
        return chosenMovieTableView
    }()

    // MARK: - Public Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        chosenMovieTableView.delegate = self
        chosenMovieTableView.dataSource = self
        subviews()
        constraints()
        presenter?.receiveMovieDetails()
    }
    
    // MARK: - Private Methods

    private func subviews() {
        view.addSubview(chosenMovieTableView)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            chosenMovieTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chosenMovieTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chosenMovieTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chosenMovieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension DetailFilmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = presenter?.elements else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: imageCellID,
                    for: indexPath
                ) as? SelectedMovieImageTableViewCell
            else { return UITableViewCell() }
            presenter?.receiveMovieDetailImage(cell: cell)
            return cell
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: descriptionCellID,
                    for: indexPath
                ) as? DetailFilmTableViewCell else { return UITableViewCell() }
            cell.descriptionText = movie.overview
            return cell
        default:
            return UITableViewCell()
        }
    }
}


// MARK: - UITableViewDelegate

extension DetailFilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}

extension DetailFilmViewController: MovieDetailViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.chosenMovieTableView.reloadData()
        }
    }
}
