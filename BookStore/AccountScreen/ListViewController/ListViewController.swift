//
//  ListViewController.swift
//  BookStore
//
//  Created by Федор Игонин on 07.12.2023.
//

import UIKit
import SnapKit

final class ListViewController: UIViewController {
    
    //MARK: - Properies
    var presenter: ListPresenterProtocol!
    
    //MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.width - 60.0, height: 60.0)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return view
    }()
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupNavigationItems() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapAdd))
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button
    }
    
    private func alert() {
        let alert = UIAlertController(title: nil, message: "What you want to add?", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "New category" }
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self?.presenter.data.append(text)
                self?.collectionView.reloadData()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func tapAdd() {
        alert()
    }
}


//MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? UICollectionViewListCell
        var context = cell?.defaultContentConfiguration()
        var backgroundContent = UIBackgroundConfiguration.listGroupedCell()
        backgroundContent.backgroundColor = .systemGray2
        backgroundContent.cornerRadius = 5
        cell?.backgroundConfiguration = backgroundContent
        context?.text = presenter.data[indexPath.row]
        context?.textProperties.color = .systemGray2
        cell?.contentConfiguration = context
        cell?.backgroundColor = .systemGray5
        cell?.layer.cornerRadius = 5
        cell?.clipsToBounds = true
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data.count
    }
}


//MARK: - UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
    }
}

//MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {}
