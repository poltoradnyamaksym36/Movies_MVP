// SelectedMovieImageTableViewCell.swift
// Copyright © VTB. All rights reserved.

import UIKit

final class SelectedMovieImageTableViewCell: UITableViewCell {
    static let identifier = "SelectedMovieImageTableViewCell"

    // MARK: - Private Properties

    let chosenMoviePosterImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let networkService = NetworkService()

    // MARK: - Private methods

    func configureImage(movie: Movie?) {
        DispatchQueue.global().async {
            guard let posterId = movie?.posterPath else { return }
            DispatchQueue.main.async {
                self.networkService.receiveImage(posterPath: posterId) { [weak self] image in
                    self?.chosenMoviePosterImageView.image = image
                }
            }
        }
    }
    
    override func layoutSubviews() {
        constraints()
    }

    private func constraints() {
        chosenMoviePosterImageView.contentMode = .scaleAspectFill
        chosenMoviePosterImageView.clipsToBounds = true
        addSubview(chosenMoviePosterImageView)
        chosenMoviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chosenMoviePosterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chosenMoviePosterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            chosenMoviePosterImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            chosenMoviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
