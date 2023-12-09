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
    //название
    let key, title: String?
    let editionCount, firstPublishYear: Int?
    let hasFulltext, publicScanB: Bool?
    let ia: [String]?
    let ia_collection_s, coverEditionKey: String?
    let cover_i: Int?
    //язык, ключ автора, имя автора
    let language, authorKey, author_name: [String]?
    let lendingEditionS, lendingIdentifierS, subtitle: String?
    let idLibrivox, idProjectGutenberg, idStandardEbooks: [String]?
    

    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(cover_i ?? 0)-M.jpg") ?? URL(fileURLWithPath: "")
    }
    
}
