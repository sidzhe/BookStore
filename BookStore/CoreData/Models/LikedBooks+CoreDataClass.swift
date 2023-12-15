//
//  LikedBooks+CoreDataClass.swift
//  BookStore
//
//  Created by macbook on 15.12.2023.
//
//

import Foundation
import CoreData

@objc(LikedBooks)
public class LikedBooks: NSManagedObject {
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(coverI)-M.jpg") ?? URL(fileURLWithPath: "")
    }
}
