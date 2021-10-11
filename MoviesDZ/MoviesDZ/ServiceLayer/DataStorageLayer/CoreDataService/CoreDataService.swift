//
//  CoreDataService.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation
import CoreData

final class CoreDataService {
    
    // MARK: - Public Properties

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    static let shared = CoreDataService()

    // MARK: - Private Properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieModel")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Initializers

    private init() {}

    // MARK: - Public methods

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


