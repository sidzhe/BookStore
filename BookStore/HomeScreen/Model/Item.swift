//
//  Item.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

struct Item: Hashable {
    var time: TimeModel?
    var book: Book?
    var work: Work?
    let identifier = UUID()
}
