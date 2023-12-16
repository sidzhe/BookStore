//
//  FavoritesViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 142)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let image = UIImage(named: "book")!
    
    //MARK: - Presenter
    var presenter: FavoritesPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        setupView()
        setupConst()
        registerCell()
        collectionView.dataSource = self
        collectionView.delegate = self
        title = "Likes"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getLikedBooks()
        reloadData()
    }
    //Register Cell
    private func registerCell() {
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.identifier)
    }
    //View Config
    private func setupView() {
        view.addSubViews(collectionView)
        view.backgroundColor = .white
    }
    //Layout
    private func setupConst() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    
    func openProduct(with model: Work) {
        let vc = Builder.createProductVC(book: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Delete Cell
    func deleteItem(at indexPath: IndexPath) {
        
        print(indexPath)
        
        // Remove cell with animation
        collectionView.performBatchUpdates {
            self.presenter.book?.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    //UICollectionView UI update
    func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: - DataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let book = presenter.book else { return 0 }
        return book.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.identifier, for: indexPath) as? FavouriteCell else {
            return UICollectionViewCell()
        }
        if let book = presenter.getBook(with: indexPath) {
            cell.config(book: book)
        }
        //Remove cell
        cell.deleteButtonTapped = {
            // Get the current indexPath for the cell at the time of clicking
            if let currentIndexPath = collectionView.indexPath(for: cell) {
                self.presenter.removeItem(at: currentIndexPath)
            }
            
        }
        return cell
        
    }
    
}

//MARK: - UICollectionView Delegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
