//
//  HomePresenter.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

//MARK: - Protocols
protocol HomeViewProtocol: AnyObject {
    func updateCellAppearance(at indexPath: IndexPath, isSelected: Bool)
    func update()
}

protocol HomePresenterProtocol: AnyObject {
    var topBooks: [Work]? { get }
    var recentBooks: [Book]? { get }
    var times: [TimeModel] { get }
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    var networkService: NetworkServiceProtocol
    private var lastSelectedIndexPath: IndexPath?
        
    var topBooks: [Work]?
    var recentBooks: [Book]?
    var times = [TimeModel(times: "This Week"), TimeModel(times: "This Month"), TimeModel(times: "This Year")]
    
    //MARK: - Init
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        topBooksRequest()
        recentBookRequest(sort: .weekly)
    }
    
    //MARK: - Methods
    
    //CollectionView Delegate
    func didSelectItemAt(_ indexPath: IndexPath) {
        // Сообщить View об изменении состояния предыдущей выбранной ячейки
        if let lastIndexPath = lastSelectedIndexPath {
            view?.updateCellAppearance(at: lastIndexPath, isSelected: false)
        }
        // Обновить текущую выбранную ячейку и изменить её внешний вид
        lastSelectedIndexPath = indexPath
        view?.updateCellAppearance(at: indexPath, isSelected: true)
    }
    
    //SearchBar Delegate
    func didTextChange(_ text: String) {
    }
    
    func didTapSearchButton(_ text: String) {
        print(text)
    }
    
    func topBooksRequest() {
        networkService.searchBooks(keyWords: "гарри") { [weak self] (result: Result<Books, Error>) in
            switch result {
            case .success(let book):
                self?.recentBooks = book.books
                DispatchQueue.main.async { self?.view?.update() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func recentBookRequest(sort: TrendingSort) {
        networkService.getTrendingBooks(sort: sort) { [weak self] (result: Result<[Work], Error>) in
            switch result {
            case .success(let trendBooks):
                self?.topBooks = trendBooks
                DispatchQueue.main.async { self?.view?.update() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
