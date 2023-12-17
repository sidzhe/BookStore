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
    let button = UIButton()
//    var buttonAction: (() -> Void)?
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    
    private func configure() {
        addSubViews(titleLabel, button)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        button.setTitle(button.isSelected ? "Hide" : "See More", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        titleLabel.font = .boldSystemFont(ofSize: 20)
    }
}
