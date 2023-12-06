//
//  APIModel.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import Foundation

// MARK: - Books
struct Books: Codable {
    let numFound, start: Int
    let numFoundExact: Bool
    let docs: [Book]
    let booksNumFound: Int
    let q: String

    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact, docs
        case booksNumFound = "num_found"
        case q
    }
}

// MARK: - Doc
struct Book: Codable {
    let key, type: String
    let seed: [String]
    let title: String
    let isbn: [String]
    let hasFulltext, publicScanB: Bool
    let ia, iaCollection: [String]
    let coverI: Int
    let authorName: [String]

    enum CodingKeys: String, CodingKey {
        case key, type, title, seed
        case isbn
        case hasFulltext = "has_fulltext"
        case publicScanB = "public_scan_b"
        case ia
        case iaCollection = "ia_collection"
        case coverI = "cover_i"
        case authorName = "author_name"
    }
}

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
            //"https://covers.openlibrary.org/b/id/240726-S.jpg"
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
        //"https://covers.openlibrary.org/b/id/240726-S.jpg"
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

// MARK: - TrendBooks
struct TrendBooks: Codable {
    let query: String
    let works: [Work]
    let days, hours: Int
}

// MARK: - Work
struct Work: Codable {
    let key, title: String
    let editionCount, firstPublishYear: Int
    let hasFulltext, publicScanB: Bool
    let ia: [String]?
    let iaCollectionS, coverEditionKey: String?
    let coverI: Int?
    let language, authorKey, authorName: [String]?
    let availability: Availability?
    let lendingEditionS, lendingIdentifierS, subtitle: String?
    let idLibrivox, idProjectGutenberg, idStandardEbooks: [String]?

    enum CodingKeys: String, CodingKey {
        case key, title
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case publicScanB = "public_scan_b"
        case ia
        case iaCollectionS = "ia_collection_s"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case language
        case authorKey = "author_key"
        case authorName = "author_name"
        case availability
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case subtitle
        case idLibrivox = "id_librivox"
        case idProjectGutenberg = "id_project_gutenberg"
        case idStandardEbooks = "id_standard_ebooks"
    }
}

// MARK: - Availability
struct Availability: Codable {
    let status: Status
    let availableToBrowse, availableToBorrow, availableToWaitlist, isPrintdisabled: Bool?
    let isReadable, isLendable, isPreviewable: Bool?
    let identifier: String
    let isbn: String?
    let openlibraryWork, openlibraryEdition: String?
    let lastLoanDate: Date?
    let numWaitlist: String?
    let lastWaitlistDate: Date?
    let isRestricted, isBrowseable: Bool
    let src: Src
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case status
        case availableToBrowse = "available_to_browse"
        case availableToBorrow = "available_to_borrow"
        case availableToWaitlist = "available_to_waitlist"
        case isPrintdisabled = "is_printdisabled"
        case isReadable = "is_readable"
        case isLendable = "is_lendable"
        case isPreviewable = "is_previewable"
        case identifier, isbn
        case openlibraryWork = "openlibrary_work"
        case openlibraryEdition = "openlibrary_edition"
        case lastLoanDate = "last_loan_date"
        case numWaitlist = "num_waitlist"
        case lastWaitlistDate = "last_waitlist_date"
        case isRestricted = "is_restricted"
        case isBrowseable = "is_browseable"
        case src = "__src__"
        case errorMessage = "error_message"
    }
}

enum Src: String, Codable {
    case coreModelsLendingGetAvailability = "core.models.lending.get_availability"
}

enum Status: String, Codable {
    case borrowAvailable = "borrow_available"
    case borrowUnavailable = "borrow_unavailable"
    case error = "error"
    case statusOpen = "open"
    case statusPrivate = "private"
}
