//
//  ProductView.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import UIKit

protocol IProductView: UIView {
    var booksName: UILabel { get }
    var author: UILabel { get }
    var category: UILabel { get }
    var rating: UILabel { get }
    var descriptionHeader: UILabel { get }
    var booksDescription: UITextView { get }
    var addToListButton: UIButton { get }
    var readButton: UIButton { get }
    var imageBook: UIImageView { get }
}

final class ProductView: UIView, IProductView {
    //MARK: - Views
    
    let booksName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    let author: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let category: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionHeader: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let booksDescription: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return text
    }()
    
    let addToListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to list", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.tintColor = .black
        return button
    }()
    
    let readButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.tintColor = .white
        return button
    }()
    
    let imageBook: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductView {
    func setupView() {
        backgroundColor = .white
        addSubviews(booksName, imageBook, author, category, rating, addToListButton, readButton, descriptionHeader, booksDescription)
        disableSubviewsTamic()
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            booksName.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            booksName.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            booksName.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            imageBook.topAnchor.constraint(equalTo: booksName.bottomAnchor, constant: 16),
            imageBook.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageBook.widthAnchor.constraint(equalToConstant: 180),
            
            author.topAnchor.constraint(equalTo: booksName.bottomAnchor, constant: 16),
            author.leadingAnchor.constraint(equalTo: imageBook.trailingAnchor, constant: 20),
            author.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            category.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 8),
            category.leadingAnchor.constraint(equalTo: imageBook.trailingAnchor, constant: 20),
            category.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            rating.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 8),
            rating.leadingAnchor.constraint(equalTo: imageBook.trailingAnchor, constant: 20),
            rating.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            addToListButton.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 21),
            addToListButton.leadingAnchor.constraint(equalTo: imageBook.trailingAnchor, constant: 20),
            addToListButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            addToListButton.heightAnchor.constraint(equalToConstant: 40),
            
            readButton.topAnchor.constraint(equalTo: addToListButton.bottomAnchor, constant: 13),
            readButton.leadingAnchor.constraint(equalTo: imageBook.trailingAnchor, constant: 20),
            readButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            readButton.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionHeader.topAnchor.constraint(equalTo: imageBook.bottomAnchor, constant: 20),
            descriptionHeader.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            booksDescription.topAnchor.constraint(equalTo: descriptionHeader.bottomAnchor),
            booksDescription.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            booksDescription.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            booksDescription.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
