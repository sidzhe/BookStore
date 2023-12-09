//
//  UILabel-ext.swift
//  BookStore
//
//  Created by macbook on 04.12.2023.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont? = .systemFont(ofSize: 10), textColor: UIColor? = .white) {
        self.init(frame: .infinite)
        if let font = font {
            self.font = font
        }
        if let color = textColor {
            self.textColor = color
        }
        
        self.numberOfLines = 0
    }
}
