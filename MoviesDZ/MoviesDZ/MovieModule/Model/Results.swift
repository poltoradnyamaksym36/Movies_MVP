// ListFilm.swift
// Copyright © VTB. All rights reserved.

import Foundation
import CoreData
/// Film Images Model
struct Results: Codable {
    var results: [ListFilms]
}

/// Film Images Model
struct ListFilms: Codable {
    var posterPath: String?
    var adult: Bool
    var overview: String?
    var releaseDate: String?
    var id: Int?
    var originalTitle: String?
    var title: String?
    var backdropPath: String?
    var popularity: Float?
    var voteCount: Int?
    var voteAverage: Float?
}



