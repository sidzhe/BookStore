//
//  WorksBook.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import Foundation

// MARK: - BooksDetail
struct WorksBook: Codable {
    let title, key: String
    let authors: [Author]
    let type: TypeClass
    let description: String
    let covers: [Int]
    let subjectPlaces, subjects, subjectPeople, subjectTimes: [String]
    let location: String
    let latestRevision, revision: Int
    let created, lastModified: Created
    
    enum CodingKeys: String, CodingKey {
        case title, key, authors, type, description, covers
        case subjectPlaces = "subject_places"
        case subjects
        case subjectPeople = "subject_people"
        case subjectTimes = "subject_times"
        case location
        case latestRevision = "latest_revision"
        case revision, created
        case lastModified = "last_modified"
    }
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(covers[0])-M.jpg") ?? URL(fileURLWithPath: "")
    }
}

struct BooksDetail: Codable {
    let description, notes: Created
    let identifiers: Identifiers
    let title: String
    let authors: [TypeElement]
    let publishDate: String
    let publishers, series: [String]
    let pagination: String
    let publishPlaces, contributions, genres, sourceRecords: [String]
    let workTitles: [String]
    let languages: [TypeElement]
    let subjects: [String]
    let publishCountry, byStatement: String
    let type: TypeElement
    let covers: [Int]
    let ocaid: String
    let isbn10, localID: [String]
    let key: String
    let numberOfPages: Int
    let works: [TypeElement]
    let latestRevision, revision: Int
    let created, lastModified: Created
    
    enum CodingKeys: String, CodingKey {
        case description, notes, identifiers, title, authors
        case publishDate = "publish_date"
        case publishers, series, pagination
        case publishPlaces = "publish_places"
        case contributions, genres
        case sourceRecords = "source_records"
        case workTitles = "work_titles"
        case languages, subjects
        case publishCountry = "publish_country"
        case byStatement = "by_statement"
        case type, covers, ocaid
        case isbn10 = "isbn_10"
        case localID = "local_id"
        case key
        case numberOfPages = "number_of_pages"
        case works
        case latestRevision = "latest_revision"
        case revision, created
        case lastModified = "last_modified"
    }
    
    var urlImage: URL {
        return URL(string: "\(NetworkConstants.imageCover)/\(covers[0])-M.jpg") ?? URL(fileURLWithPath: "")
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

// MARK: - TypeElement
struct TypeElement: Codable {
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

// MARK: - Identifiers
struct Identifiers: Codable {
    let goodreads, librarything: [String]
}

