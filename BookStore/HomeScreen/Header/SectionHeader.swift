//
//  SectionHEader.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import UIKit

//MARK: - Header for sections
final class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "header"
    let titleLabel = UILabel()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func configure() {
           addSubview(titleLabel)
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               titleLabel.heightAnchor.constraint(equalToConstant: 20),
               titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
               titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
           
           titleLabel.font = .boldSystemFont(ofSize: 20)
       }
}
