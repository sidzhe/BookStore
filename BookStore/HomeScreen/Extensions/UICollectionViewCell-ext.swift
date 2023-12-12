//
//  UICollectionViewCell-ext.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//


import UIKit

extension UICollectionViewCell {
    class var identifier: String { return String(describing: Self.self) }
    
    func clearBackgroudColor() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
}
