//
//  ReadingModel.swift
//  BookStore
//
//  Created by sidzhe on 13.12.2023.
//

import Foundation

// MARK: - ReadingModel
struct ReadingModel: Codable {
    let responseHeader: ResponseHeader?
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let numFound, start: Int?
    let docs: [Doc]?
}

// MARK: - Doc
struct Doc: Codable {
    let identifier: String?
}

// MARK: - ResponseHeader
struct ResponseHeader: Codable {
    let status, qTime: Int?
    let params: Params?

    enum CodingKeys: String, CodingKey {
        case status
        case qTime = "QTime"
        case params
    }
}

// MARK: - Params
struct Params: Codable {
    let query, qin, fields, wt: String?
    let rows: String?
    let start: Int?
}
