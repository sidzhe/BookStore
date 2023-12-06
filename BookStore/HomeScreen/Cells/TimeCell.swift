//
//  TimeCell.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import UIKit

final class TimeCell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConst()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 6 
        contentView.clipsToBounds = true
        contentView.addSubview(label)
    }
    
    private func setupConst() {
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func config(with text: TimeModel) {
        label.text = text.times
        label.sizeToFit()
    }
    
    func color(_ color: UIColor) {
        contentView.backgroundColor = color
        if color == UIColor.black {
            self.label.textColor = .white
        } else {
            self.label.textColor = .black
        }
    }
}
