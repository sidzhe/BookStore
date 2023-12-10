//
//  CategoriesViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: CategoriesPresenterProtocol!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    //MARK: - UI Elements
    private lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Search category"
        searchBar.searchBar.searchTextField.clearButtonMode = .always
        searchBar.automaticallyShowsCancelButton = false
        return searchBar
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureDataSource()
        applyInitialSnapshots()
        
    }
    
    //MARK: - Filter
    private func performQuery(with filter: String?) {
        presenter.currentText = filter
        let text = presenter.filteredPairs(with: filter)
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([.min])
        snapshot.appendItems(text)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension CategoriesViewController
private extension CategoriesViewController {
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, str) in
            var content = cell.defaultContentConfiguration()
            var backgroundContent = UIBackgroundConfiguration.listGroupedCell()
            backgroundContent.image = UIImage(named: "cellBack")
            cell.backgroundConfiguration = backgroundContent
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 5
            content.text = str
            content.textProperties.alignment = .center
            content.textProperties.font = .systemFont(ofSize: 22, weight: .semibold)
            content.textProperties.color = .white
            cell.contentConfiguration = content
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <HeaderCell>(elementKind: "Header") { (supplementaryView, string, indexPath) in
            supplementaryView.label.text = "Categories"
            supplementaryView.label.textColor = .black
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, string: String) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: string)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
    }
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(presenter.categoriesModel)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - Layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let spacing = CGFloat(20)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.interItemSpacing = .fixed(spacing)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                            elementKind: "Header",
                                                                            alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        
        return layout
    }
    
    //MARK: - UI
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


//MARK: - UISearchBarDelegate
extension CategoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.categoriesModel[indexPath.row]
        print(item.lowercased())
        presenter.requestCategorise(item.lowercased())
    }
}

//MARK: - CategoriesViewProtocol
extension CategoriesViewController: CategoriesViewProtocol {
    
}
