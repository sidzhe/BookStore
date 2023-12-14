//
//  BookCD+CoreDataProperties.swift
//  BookStore
//
//  Created by macbook on 14.12.2023.
//
//

import Foundation
import CoreData


extension BookCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookCD> {
        return NSFetchRequest<BookCD>(entityName: "BookCD")
    }

    @NSManaged public var iaCollection: String?
    @NSManaged public var title: String?
    @NSManaged public var authorName: String?
    @NSManaged public var urlImage: String?

}

extension BookCD : Identifiable {

}
