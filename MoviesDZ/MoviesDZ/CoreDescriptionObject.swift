//
//  CoreDescription.swift
//  MoviesDZ
//
//  Created by Max Inedom on 10/10/21.
//

import Foundation
import CoreData

@objc(CoreDescriptionObject)
class CoreDescriptionObject: NSManagedObject {
    @NSManaged var posterPath: String
}
