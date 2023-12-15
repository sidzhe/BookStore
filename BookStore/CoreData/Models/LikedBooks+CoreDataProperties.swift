//
//  LikedBooks+CoreDataProperties.swift
//  BookStore
//
//  Created by macbook on 15.12.2023.
//
//

import Foundation
import CoreData


extension LikedBooks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedBooks> {
        return NSFetchRequest<LikedBooks>(entityName: "LikedBooks")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var key: String?
    @NSManaged public var coverI: Int64

}

extension LikedBooks : Identifiable {

}
