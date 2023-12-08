//
//  Books.swift
//  BookStore
//
//  Created by sidzhe on 06.12.2023.
//

import Foundation

// MARK: - Books
struct Books: Codable, Hashable {
//    let numFound, start: Int?
//    let numFoundExact: Bool?
    let books: [Book]?
//    let booksNumFound: Int?
//    let q: String?

    enum CodingKeys: String, CodingKey {
//        case numFound, start, numFoundExact, 
        case books = "docs"
//        case booksNumFound = "num_found"
//        case q
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
//    let isbn: [String]?
//    let hasFulltext, publicScanB: Bool?
    let ia, iaCollection: [String]?
    let coverI: Int?
    let authorName: [String]?

    enum CodingKeys: String, CodingKey {
        case key, type, title, seed
//        case isbn
//        case hasFulltext = "has_fulltext"
//        case publicScanB = "public_scan_b"
        case ia
        case iaCollection = "ia_collection"
        case coverI = "cover_i"
        case authorName = "author_name"
    }
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(coverI ?? 0)-M.jpg") ?? URL(fileURLWithPath: "")
    }
}
