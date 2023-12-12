//
//  Books.swift
//  BookStore
//
//  Created by sidzhe on 06.12.2023.
//

import Foundation

// MARK: - Books
struct Books: Codable, Hashable {
    let books: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case books = "docs"
    }
}

struct BooksByCategories: Codable {
    let key, name: String?
    let workCount: Int?
    let works: [Work]
    
    enum CodingKeys: String, CodingKey {
        case key, name
        case workCount = "work_count"
        case works
    }
}

// MARK: - Book
struct Book: Codable, Hashable {
    let key, type: String?
    let seed: [String]?
    let title: String?
    let ia, iaCollection: [String]?
    let coverI: Int?
    let authorName: [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case key, type, title, seed
        case ia
        case iaCollection = "ia_collection"
        case coverI = "cover_i"
        case authorName = "author_name"
    }
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(coverI ?? 0)-M.jpg") ?? URL(fileURLWithPath: "")
    }
}



