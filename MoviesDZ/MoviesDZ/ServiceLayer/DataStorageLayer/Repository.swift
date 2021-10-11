//
//  Repository.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation

protocol DataBaseProtocol {
    func get() -> [CoreMovieObject]
    func save(object: [ListFilms])
    func remove(id: Int)
}

final class Repository: DataBaseProtocol {
    
    var dataBase: DataBaseProtocol
    
    init(database: DataBaseProtocol) {
        self.dataBase = database
    }
    
    func get() -> [CoreMovieObject] {
        dataBase.get()
    }
    
    func save(object: [ListFilms]) {
        dataBase.save(object: object)
    }
    
    func remove(id: Int) {
        dataBase.remove(id: id)
    }
}
