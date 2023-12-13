//
//  ListViewController.swift
//  BookStore
//
//  Created by Федор Игонин on 07.12.2023.
//

import UIKit
import SnapKit

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.width - 20.0, height: 60.0)
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        return view
    }()
    let cellIdentifier = "cell"
    
    let data = ["Want to read", "Classic books", "Read for fun"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? UICollectionViewListCell
        var context = cell?.defaultContentConfiguration()
        var backgroundContent = UIBackgroundConfiguration.listGroupedCell()
        backgroundContent.backgroundColor = .systemGray2
        backgroundContent.cornerRadius = 5
        cell?.backgroundConfiguration = backgroundContent
        context?.text = data[indexPath.row]
        cell?.contentConfiguration = context
        cell?.backgroundColor = .systemGray2
        cell?.layer.cornerRadius = 5
        cell?.clipsToBounds = true
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}


