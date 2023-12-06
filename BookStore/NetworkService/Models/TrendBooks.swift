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
    let editionCount, firstPublishYear: Int?
    let hasFulltext, publicScanB: Bool?
    let ia: [String]?
    let iaCollectionS, coverEditionKey: String?
    let coverI: Int?
    let language, authorKey, authorName: [String]?
    let lendingEditionS, lendingIdentifierS, subtitle: String?
    let idLibrivox, idProjectGutenberg, idStandardEbooks: [String]?

    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(coverI ?? 0)-M.jpg") ?? URL(fileURLWithPath: "")
    }
}
