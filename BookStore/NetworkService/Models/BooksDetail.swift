//
//  WorksBook.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import Foundation

// MARK: - BooksDetail

struct BooksDetail: Codable {
    let description: Descript?
    let subjects: [String]?
    let key, title: String?
    let authors: [Author]?
    let covers: [Int]
    let links: [Link]?

    enum CodingKeys: String, CodingKey {
        case description, subjects, key, title, authors, covers, links
    }
    
    enum Descript: Codable {
        case string(String)
        case created(Created)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Created.self) {
                self = .created(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(Descript.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .created(let x):
                try container.encode(x)
            case .string(let x):
                try container.encode(x)
            }
        }
        
        func stringValue() -> String? {
            if case let .string(value) = self {
                return value
            }
            return nil
        }
        
        func createdValue() -> Created? {
            if case let .created(value) = self {
                return value
            }
            return nil
        }
    }
    
    var urlImage: URL? {
        return URL(string: "\(NetworkConstants.imageCover)/\( covers[0])-M.jpg") ?? URL(fileURLWithPath: "")
    }
}


// MARK: - Author
struct Author: Codable {
    let author, type: TypeClass
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let key: String
}

// MARK: - Created
struct Created: Codable {
    let type, value: String
}

// MARK: - Rating
struct Rating: Codable {
    let summary: Summary
    let counts: [String: Int]
}

// MARK: - Summary
struct Summary: Codable {
    let average: Double
    let count: Int
    let sortable: Double
}

// MARK: - Link
struct Link: Codable {
    let title: String
    let url: String
    let type: TypeClass
}

