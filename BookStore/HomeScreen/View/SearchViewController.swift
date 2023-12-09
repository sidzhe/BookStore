//
//  SearchViewController.swift
//  BookStore
//
//  Created by macbook on 09.12.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 140)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()    
    var presenter: SearchPresenterProtocol!
    private var books: [Book]?
    
    init(books: [Book]? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.books = books
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setupView()
        setupConst()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .white
        
    }
    
    private func register() {
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
    }
    private func setupView() {
        view.addSubViews(collectionView)
    }
    private func setupConst() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let book = books {
            return book.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
            if let books = self.books {
                let book = books[indexPath.row]
                cell.config(book: book)
            }
        }

        return cell
    }
    
    
}
