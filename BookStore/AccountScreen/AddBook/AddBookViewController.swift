//
//  AddBookViewController.swift
//  BookStore
//
//  Created by sidzhe on 16.12.2023.
//

import UIKit

final class AddBookViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: AddBookPresenterProtocol!
    
    //MARK: - UI Elements
    private let image = UIImage(named: "book")
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 142)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(AddBookCell.self, forCellWithReuseIdentifier: AddBookCell.id)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = true
        searchBar.searchBar.placeholder = "Search book"
        searchBar.searchBar.searchTextField.clearButtonMode = .always
        searchBar.automaticallyShowsCancelButton = false
        return searchBar
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavagation()
        setupView()
        
    }
    
    //MARK: - SetupUI
    private func setupView() {
        view.backgroundColor = .white
        view.addSubViews(collectionView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupNavagation() {
        title = presenter.title
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let buttonLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapBack))
        buttonLeft.tintColor = .black
        navigationItem.leftBarButtonItem = buttonLeft
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - AddBookViewProtocol
extension AddBookViewController: AddBookViewProtocol {
    func update() {
        collectionView.reloadData()
    }
}

//MARK: - DataSource
extension AddBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowsCount = presenter.book?.count ?? 0
        rowsCount == 0 ? indicator.startAnimating() : indicator.stopAnimating()
        return rowsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddBookCell.id, for: indexPath) as? AddBookCell
        guard let model = presenter.book else { return UICollectionViewCell () }
        var state = CoreDataManager.shared.isBookList(bookKey: model[indexPath.row].key ?? "")
        cell?.addListCallBack = { [weak self] in
            let book = model[indexPath.row]
            CoreDataManager.shared.saveListBook(from: book, parentName: self?.title ?? "")
        }
        cell?.config(book: model[indexPath.row], state: state)
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - UICollectionView Delegate
extension AddBookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = presenter.book?[indexPath.row]
        let work = Work(key: book?.key, title: book?.title, coverEditionKey: nil, cover_i: book?.coverI, authorName: book?.authorName)
        let productViewController = Builder.createProductVC(book: work)
        present(productViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension AddBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchRequest(keyWords: text)
        searchBar.resignFirstResponder()
    }
}
