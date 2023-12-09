//
//  Section.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

//MARK: - Enum for sections
enum Section: Int, CustomStringConvertible, CaseIterable {
    case time, topBooks, recentBooks
    var description: String {
        switch self {
        case .time:
            return "Time"
        case .topBooks:
            return "Top Books"
        case .recentBooks:
            return "Recent Books"
        
        }
    }
}
