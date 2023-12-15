//
//  SearchViewController.swift
//  BookStore
//
//  Created by macbook on 09.12.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: SearchPresenterProtocol!
    
    //MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 142)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        setupView()
        setupConst()
        view.backgroundColor = .white
        
    }
    
    private func register() {
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
    }
    
    private func setupView() {
        view.addSubview(closeButton)
        view.addSubViews(collectionView, activityIndicator)
        activityIndicator.color = .label
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalToSuperview().inset(55)
            make.right.equalToSuperview().inset(40)
        }
    }
    
    @objc private func tapClose() {
        dismiss(animated: true)
    }
}


//MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = presenter.books?[indexPath.row]
        let work = Work(key: book?.key, title: book?.title, coverEditionKey: nil, cover_i: book?.coverI, authorName: book?.authorName)
        let productViewController = Builder.createProductVC(book: work)
        present(productViewController, animated: true)
    }
}


//MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.books?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell
        guard let model = presenter.books else { return UICollectionViewCell () }
        cell?.config(book: model[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - SearchViewProtocol
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
