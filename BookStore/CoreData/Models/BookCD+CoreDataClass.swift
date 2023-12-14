//
//  BookCD+CoreDataClass.swift
//  BookStore
//
//  Created by macbook on 14.12.2023.
//
//

import Foundation
import CoreData

@objc(BookCD)
public class BookCD: NSManagedObject {
    var imageUrl: URL? {
        return URL(string: self.urlImage ?? "")
    }
}
