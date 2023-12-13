//
//  UIView-ext.swift
//  BookStore
//
//  Created by macbook on 04.12.2023.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor? = .white) {
        self.init(frame: .infinite)
        if let color = backgroundColor {
            self.backgroundColor = color
        }
    }
    
    func addSubViews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
}
