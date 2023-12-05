//
//  LayoutController.swift
//  CompositionalLayout
//
//  Created by macbook on 04.12.2023.
//


import UIKit

final class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private let image = UIImage(named: "book")!
    private let searchController = UISearchController(searchResultsController: nil)
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        configureCollectionView()
        configureDataSource()
        updateWithData(topBooks: presenter.topBooks, recentBooks: presenter.recentBooks, times: presenter.times)
        view.backgroundColor = .white
        setupSearchController()
        

    }
    

    //MARK: - SearchBar setup
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Happy Reading!"
        navigationItem.searchController = searchController
    }
    
    
    //MARK: - CollectionViewConfig
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        // Регистрация ячеек
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: BookCell.identifier)
        collectionView.register(TimeCell.self, forCellWithReuseIdentifier: TimeCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    
    //MARK: - Layout
    private func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .time:
                // Создаем секцию для временных интервалов (This Week, This Month, This Year)
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                // Добавляем заголовок к секции
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                
                section.boundarySupplementaryItems = [header]
                return section
            
            case .topBooks:
                // Создаем секцию для книг
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(175), heightDimension: .absolute(230))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case .recentBooks:
                // Создаем секцию для книг
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(175), heightDimension: .absolute(230))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                // Добавляем заголовок к секции
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.pinToVisibleBounds = false
                header.zIndex = 2
                
                section.boundarySupplementaryItems = [header]

                return section
            
            default:
                // Возвращаем nil для неизвестных секций
                return nil
            }
        }
    }
    
    
    //MARK: - Registration Methods
    private func registerTime() -> UICollectionView.CellRegistration<TimeCell, TimeModel> {
        return UICollectionView.CellRegistration<TimeCell, TimeModel> { (cell, indexPath, timeModel) in
            cell.config(with: timeModel)
        }
        
    }
    
    private func registerBook() -> UICollectionView.CellRegistration<BookCell, BookModel> {
        return UICollectionView.CellRegistration<BookCell, BookModel> { (cell, indexPath, bookModel) in
            cell.config(book: bookModel, image: self.image)
        }
    }
    
    private func registerTopHeader() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "Top Books"
        }
    }
    
    private func registerRecentHeader() -> UICollectionView.SupplementaryRegistration<SectionHeader> {
        return UICollectionView.SupplementaryRegistration<SectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "Recent Books"
        }
    }
    
    //MARK: - DataSource
    private func configureDataSource() {
        // Регистрация для TimeCell
        let timeCellRegistration = registerTime()
        
        // Регистрация для BookCell
        let bookCellRegistration = registerBook()
        
        // Регистрация для Top Books Header
        let topBooksHeader = registerTopHeader()
        
        // Регистрация для Recent Books Header
        let recentBooksHeader = registerRecentHeader()
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            // Определяем тип ячейки на основе секции
            switch Section(rawValue: indexPath.section)! {
            case .time:
                return collectionView.dequeueConfiguredReusableCell(using: timeCellRegistration, for: indexPath, item: item.time!)
            case .topBooks, .recentBooks:
                // Oбе секции используют BookModel
                return collectionView.dequeueConfiguredReusableCell(using: bookCellRegistration, for: indexPath, item: item.book)
            }
        }
        
        // Настройка заголовков секций
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Section(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .time:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: topBooksHeader, for: indexPath)
                    case .topBooks:
                        return nil
                    case .recentBooks:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: recentBooksHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    

}


//MARK: - SearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    // Расширение для обработки  поиска
        // Вызывается, когда текст изменяется
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            presenter.didTextChange(searchText)
        }
        
        // Вызывается, когда пользователь нажимает кнопку
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let searchText = searchBar.text {
                presenter.didTapSearchButton(searchText)
            }
        }
    }

//MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
//            guard let cell = collectionView.cellForItem(at: indexPath) as? TimeCell else { return }
            
        case 1:
            guard let cell = collectionView.cellForItem(at: indexPath) as? BookCell else { return }
            let vc = DescriptionViewController(book: presenter.topBooks[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            guard let cell = collectionView.cellForItem(at: indexPath) as? BookCell else { return }
            let vc = DescriptionViewController(book: presenter.recentBooks[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
            
        default: break
        }
    }
    

    //Цвет ячеек
        func didSelectItemAt(at indexPath: IndexPath, isSelected: Bool) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? TimeCell else { return }
            
            cell.color(isSelected ? .black : .clear)
            

            
        }
    
    
    //MARK: - SnapShot
    
    func updateWithData(topBooks: [BookModel], recentBooks: [BookModel], times: [TimeModel]) {
        // Создаем начальный снимок и применяем его к DataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.time, .topBooks, .recentBooks])
                let timeItems = times.map { Item(time: $0) } /*times.map { Item(time: $0, book: nil) }*/
                snapshot.appendItems(timeItems, toSection: .time)
                let topBookItems = topBooks.map { Item(book: $0) } /*topBooks.map { Item(book: $0) }*/
                snapshot.appendItems(topBookItems, toSection: .topBooks)
                let recentBookItems = recentBooks.map { Item(book: $0) } /*recentBooks.map { Item(book: $0) }*/
                snapshot.appendItems(recentBookItems, toSection: .recentBooks)
            
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

//MARK: - UICollectionView Delegate
extension HomeViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath)
        presenter.didSelectItem(indexPath)
    }
}
