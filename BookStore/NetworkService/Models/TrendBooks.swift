//
//  TrendBooks.swift
//  BookStore
//
//  Created by sidzhe on 06.12.2023.
//

import Foundation

// MARK: - TrendBooks
struct TrendBooks: Codable, Hashable {
    let query: String?
    let works: [Work]
    let days, hours: Int?
}

// MARK: - Work
struct Work: Codable, Hashable {
    let key, title: String?
    let coverEditionKey: String?
    let cover_i: Int?
    let authorName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case key, title, coverEditionKey = "cover_edition_key", authorName = "author_name", cover_i
    }

    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(cover_i ?? 0)-M.jpg") ?? URL(fileURLWithPath: "")
    }
}
