//
//  BookCell.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import UIKit

final class BookCell: UICollectionViewCell {
    
    private let topView = UIView(backgroundColor: .systemGray3)
    private let bottomView = UIView(backgroundColor: .black)
    
    private let bookImage = UIImageView()
    
    private let genre = UILabel(font: .systemFont(ofSize: 10))
    private let bookName = UILabel(font: .boldSystemFont(ofSize: 15))
    private let author = UILabel(font: .boldSystemFont(ofSize: 10))
    
    private lazy var stackView = UIStackView(.vertical, 5, .fill, .equalSpacing, [genre, bookName, author])
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubViews(topView, bottomView)
        bottomView.addSubViews(stackView)
        topView.addSubViews(bookImage)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomView.bottomAnchor, constant: 5),
            
            bookImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10),
            bookImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 45),
            bookImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10), //По дизайну картинка заходит под topAnchor bottomView
            bookImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -45)
        ])
    }
    
    func config(book: BookModel, image: UIImage) {
        self.genre.text = book.genre
        self.bookName.text = book.bookName
        self.author.text = book.author
        self.bookImage.image = image
    }

}

