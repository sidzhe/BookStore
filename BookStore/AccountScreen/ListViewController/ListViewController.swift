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
        view.register(ListCell.self, forCellWithReuseIdentifier: ListCell.id)
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        setupViews()
        
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupNavigationItems() {
        title = "List"
        let buttonRigth = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(tapAdd))
        let buttonLeft = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(tapBack))
        buttonRigth.tintColor = .black
        buttonLeft.tintColor = .black
        navigationItem.rightBarButtonItem = buttonRigth
        navigationItem.leftBarButtonItem = buttonLeft
    }
    
    private func alert() {
        let alert = UIAlertController(title: nil, message: "What you want to add?", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "New category" }
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self?.presenter.data.insert(text, at: 0)
                self?.presenter.saveList(listName: text)
                self?.collectionView.reloadData()
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func tapAdd() {
        alert()
    }
    
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.id, for: indexPath) as? ListCell
        cell?.configure(presenter.data[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.data.count
    }
}


//MARK: - UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = presenter.data[indexPath.row]
        let wantVC = Builder.createWantVC(title: title)
        navigationController?.pushViewController(wantVC, animated: true)
    }
}

//MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {}
