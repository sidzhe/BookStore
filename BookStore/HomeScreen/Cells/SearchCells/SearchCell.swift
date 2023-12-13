//
//  SearchCell.swift
//  BookStore
//
//  Created by macbook on 09.12.2023.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    private let bookImage = UIImageView()
    private let genre = UILabel(font: .systemFont(ofSize: 10), textColor: .white)
    private let bookName = UILabel(font: .boldSystemFont(ofSize: 15), textColor: .white)
    private let author = UILabel(font: .boldSystemFont(ofSize: 10), textColor: .white)
    private lazy var stackView = UIStackView(.vertical, 5, .fill, .equalSpacing, [genre, bookName, author])
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupView() {
        contentView.addSubViews(bookImage, stackView)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .black
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bookImage.heightAnchor.constraint(equalToConstant: 142),
            bookImage.widthAnchor.constraint(equalToConstant: 95),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            stackView.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 10),
        ])
    }
    
    //MARK: - Configure
    func config(book: Book) {
        self.genre.text = book.iaCollection?.first
        self.bookName.text = book.title
        self.author.text = book.authorName?.first
        self.bookImage.kf.setImage(with: book.urlImage)
    }
}
