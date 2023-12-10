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
        layout.itemSize = CGSize(width: 320, height: 142)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var presenter: SearchPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setupView()
        setupConst()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = .white
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            self.activityIndicator.stopAnimating()
//        }
//    }
    
    private func register() {
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
    }
    private func setupView() {
        view.addSubViews(collectionView, activityIndicator)
        activityIndicator.color = .label
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    private func setupConst() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let book = presenter.books {
            return book.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        if let book = presenter.getBook(at: indexPath) {
            cell.config(book: book)
            collectionView.reloadData()
        }
        return cell
    }
    
    
}

extension SearchViewController: SearchViewProtocol {
    func animating(_ start: Bool) {
        DispatchQueue.main.async {
            start ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    

    
    func reloadData() {
        collectionView.reloadData()
    }
    
    
}
