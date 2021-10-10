//
//  DataStorageService.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation

protocol DataStorageServiceProtocol {
    func save(object: [ListFilms])
    func get() -> [CoreMovieObject]
}


final class DataStorageService: DataStorageServiceProtocol {
    
    private let repository = Repository(database: CoreDataMovies())
    
    func save(object: [ListFilms]) {
        repository.save(object: object)
    }
    
    func get() -> [CoreMovieObject] {
        repository.get()
    }
    
    
}
