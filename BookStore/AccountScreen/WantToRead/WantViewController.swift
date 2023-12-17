//
//  WantViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class WantViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: WantPresenterProtocol!
    
    //MARK: - UI Elements
    private let image = UIImage(named: "book")
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 142)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(WantToReadCell.self, forCellWithReuseIdentifier: WantToReadCell.id)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavagation()
        setupView()
        
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.getLikedBooks()
        collectionView.reloadData()
        
    }
    
    //View Config
    private func setupView() {
        title = presenter.title
        view.backgroundColor = .white
        view.addSubViews(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupNavagation() {
          title = presenter.title
          let buttonRigth = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(tapAdd))
          let buttonLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapBack))
          buttonRigth.tintColor = .black
          buttonLeft.tintColor = .black
          navigationItem.rightBarButtonItem = buttonRigth
          navigationItem.leftBarButtonItem = buttonLeft
      }
    
    @objc private func tapAdd() {
        let addBookVC = Builder.createAddBookVC(title: presenter.title)
        navigationController?.pushViewController(addBookVC, animated: true)
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - FavoritesViewProtocol
extension WantViewController: WantViewProtocol {
    
    func openProduct(with model: Book) {
//        let vc = Builder.createProductVC(book: model)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Delete Cell
    func deleteItem(at indexPath: IndexPath) {
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
extension WantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let book = presenter.book else { return 0 }
        return book.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WantToReadCell.id, for: indexPath) as? WantToReadCell else {
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
extension WantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
