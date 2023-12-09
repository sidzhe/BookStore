//
//  Protocol.swift
//  BookStore
//
//  Created by sidzhe on 09.12.2023.
//

import Foundation

struct DetailBookItem: Codable, Hashable {
    var booksDetail: BooksDetail?
    var detailModel: DetailModel?
}
