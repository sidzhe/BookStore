//
//  Helpers.swift
//  BookStore
//
//  Created by sidzhe on 06.12.2023.
//

import Foundation

enum NetworkConstants {
    static let baseUrl = "https://openlibrary.org"
    static let imageCover = "https://covers.openlibrary.org/b/id"
}

enum Endpoint: String {
    case search = "/search.json?q="
    case trending = "/trending"
    case ratings = "/ratings"
}

enum TrendingSort: String {
    case daily = "/daily"
    case weekly = "/weekly"
    case monthly = "/monthly"
}
