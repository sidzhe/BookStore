//
//  HeaderCell.swift
//  BookStore
//
//  Created by sidzhe on 08.12.2023.
//

import UIKit

final class HeaderCell: UICollectionReusableView {
    
    //MARK: - Properties
    let label = UILabel()
    
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HeaderCell {
    func configure() {
        label.backgroundColor = .white
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        label.font = .systemFont(ofSize: 20, weight: .semibold)
    }
}
