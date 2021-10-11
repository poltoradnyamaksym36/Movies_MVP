//
//  CoreMovie.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation
import CoreData

@objc(CoreMovieObject)
class CoreMovieObject: NSManagedObject {
    @NSManaged var posterPath: String
    @NSManaged var adult: Bool
    @NSManaged var overview: String
    @NSManaged var releaseDate: String
    @NSManaged var id: Int
    @NSManaged var originalTitle: String
    @NSManaged var title: String?
    @NSManaged var backdropPath: String
    @NSManaged var popularity: Float
    @NSManaged var voteCount: Int
    @NSManaged var voteAverage: Float
}
