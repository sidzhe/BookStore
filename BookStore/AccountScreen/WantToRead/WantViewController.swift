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
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 140)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let image = UIImage(named: "book")!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavagation()
        setupView()
        
    }
    
    //MARK: - Setup UI
    
    private func setupNavagation() {
        title = presenter.title
        let buttonRigth = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(tapAdd))
        let buttonLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapBack))
        buttonRigth.tintColor = .black
        buttonLeft.tintColor = .black
        navigationItem.rightBarButtonItem = buttonRigth
        navigationItem.leftBarButtonItem = buttonLeft
    }
    private func setupView() {
        view.backgroundColor = .white
        view.addSubViews(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func tapAdd() {
       
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - FavoritesViewProtocol
extension WantViewController: WantViewProtocol {
    
    
    func deleteItem(at indexPath: IndexPath) {
        
        print(indexPath)
        
        collectionView.performBatchUpdates {
            self.presenter.models.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: - DataSource
extension WantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.identifier, for: indexPath) as? FavouriteCell else {
            return UICollectionViewCell()
        }
        let book = presenter.getBook(with: indexPath)
        cell.config(book: book, image: image)
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

extension WantViewController: UICollectionViewDelegate {
    
}
