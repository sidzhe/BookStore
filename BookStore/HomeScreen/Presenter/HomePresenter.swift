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
    func openSearchController(with text: String)
}

protocol HomePresenterProtocol: AnyObject {
    var topBooks: [Work]? { get }
    var recentBooks: [Work]? { get }
    var times: [TimeModel] { get }
    var searhedBook: [Book]? { get }
    func didTextChange(_ text: String)
    func didTapSearchButton(_ text: String)
    func didSelectItemAt(_ indexPath: IndexPath)
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    var networkService: NetworkServiceProtocol
    private var lastSelectedIndexPath: IndexPath?
        
    var topBooks: [Work]?
    var recentBooks: [Work]?
    var searhedBook: [Book]?
    var times = [TimeModel(times: "This Week"), TimeModel(times: "This Month"), TimeModel(times: "This Year")]
    
    //MARK: - Init
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
//        topBooksRequest()
        timeBookRequest(sort: .daily) {
            self.view?.update()
        }
    }
    
    //MARK: - Methods
    

    // CollectionView Delegate
    func didSelectItemAt(_ indexPath: IndexPath) {
        if indexPath.section == 0 {
            // Обновление состояния предыдущей выбранной ячейки
            if let lastIndexPath = lastSelectedIndexPath {
                times[lastIndexPath.row].isSelected = false
                view?.updateCellAppearance(at: lastIndexPath, isSelected: false)
            }
            // Обновление текущей выбранной ячейки
            lastSelectedIndexPath = indexPath
            times[indexPath.row].isSelected = true
            view?.updateCellAppearance(at: indexPath, isSelected: true)

            // Выполнение запроса в зависимости от выбранного времени
            let selectedTimeModel = times[indexPath.row]
            switch selectedTimeModel.times {
            case "This Week":
                print("Запрос ушел")
                timeBookRequest(sort: .daily) {
                    print("Ответ получен")
                    self.view?.update()
                }
            case "This Month":
                print("Запрос ушел")
                timeBookRequest(sort: .weekly) {
                    print("Ответ получен")
                    self.view?.update()
                }
            case "This Year":
                print("Запрос ушел")
                timeBookRequest(sort: .monthly) {
                    print("Ответ получен")
                    self.view?.update()
                }
            default:
                break
            }
        }
    }

    
    //SearchBar Delegate
    func didTextChange(_ text: String) {
    }
    
    
    func didTapSearchButton(_ text: String) {
        print("Текст передан контроллеру из презентора - \(text)")
        view?.openSearchController(with: text)
    }
    
//    func topBooksRequest() {
//        networkService.searchBooks(keyWords: "гарри") { [weak self] (result: Result<Books, Error>) in
//            switch result {
//            case .success(let book):
//                self?.recentBooks = book.docs
////                self?.topBooks = book.docs
//                self?.view?.update()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func timeBookRequest(sort: TrendingSort, completion: @escaping () -> Void) {
        networkService.getTrendingBooks(sort: sort) { [weak self] (result: Result<[Work], Error>) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let trendBooks):
                    self?.topBooks = trendBooks
                    self?.recentBooks = trendBooks
                    print(trendBooks[0].cover_i)
//                    print(self.!recentBooks![0].coverI)
//                    self?.topBooks = trendBooks.map { Book(
//                        key: $0.key,
//                        type: nil,
//                        seed: nil,
//                        title: $0.title,
//                        isbn: nil,
//                        hasFulltext: $0.hasFulltext,
//                        publicScanB: $0.publicScanB,
//                        ia: $0.ia,
//                        iaCollection: nil,
//                        coverI: $0.coverI,
//                        authorName: $0.authorName
//                    )}
//                    // Преобразование Work в Book
                    self?.view?.update()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion()
            }
        }
    }

}
