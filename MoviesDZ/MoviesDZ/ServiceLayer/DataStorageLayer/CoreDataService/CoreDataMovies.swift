//
//  CoreDataMovies.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation
import CoreData

final class CoreDataMovies: DataBaseProtocol {
    
    private let coreDataService = CoreDataService.shared
    
    
    func get() -> [CoreMovieObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CoreMovieObject.self))
        guard let result = try? coreDataService.context.fetch(fetchRequest) as? [CoreMovieObject] else { return [] }
    
        return result
    }
    
    func save(object: [ListFilms]) {
        for movie in object {
            let movieModel = CoreMovieObject(context: coreDataService.context)
            movieModel.id = movie.id ?? 0
            movieModel.originalTitle = movie.originalTitle ?? ""
            movieModel.posterPath = movie.posterPath ?? ""
            movieModel.overview = movie.overview ?? ""
            movieModel.title = movie.title ?? ""
            coreDataService.saveContext()
        }
    }
    
    func getDescription(id _: Int) -> [Movie] {
        []
    }

    func addDescription(object _: [Movie], id _: Int) {}
    func remove(id _: Int) {}

    func removeAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CoreMovieObject.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? coreDataService.context.execute(deleteRequest)
        coreDataService.saveContext()
    }
    
}
