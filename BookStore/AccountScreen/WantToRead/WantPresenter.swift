//
//  WantPresent.swift
//  BookStore
//
//  Created by sidzhe on 16.12.2023.
//

import Foundation

//MARK: - Protocols
protocol WantViewProtocol: AnyObject {
    func deleteItem(at indexPath: IndexPath)
    func reloadData()
    func openProduct(with model: Book)
}

protocol WantPresenterProtocol: AnyObject {
    var title: String { get }
    var book: [Book]? { get set }
    func getBook(with indexPath: IndexPath) -> Book?
    func getLikedBooks()
    func removeItem(at indexPath: IndexPath)
    func didSelectItemAt(indexPath: IndexPath)
    init(view: WantViewProtocol, title: String)
}

//MARK: - FavoritesPresenter
final class WantPresenter: WantPresenterProtocol {
    
    //MARK: - Properties
    weak var view: WantViewProtocol?
    var book: [Book]?
    var coreData = CoreDataManager.shared
    var title: String
    
    //MARK: - Init
    required init(view: WantViewProtocol, title: String) {
        self.view = view
        self.title = title
//        getLikedBooks()
        
    }
    
    //Логика получения книги
    func getBook(with indexPath: IndexPath) -> Book? {
        return book?[indexPath.row]
    }
    func getLikedBooks() {
        book = coreData.loadListItems(parentCategory: title)
    }
    //Логика удаления ячейки
    func removeItem(at indexPath: IndexPath) {
        guard let book = book else { return }
        guard indexPath.row < book.count else { return }
        // Сообщаем контроллеру о необходимости обновления
        if book.isEmpty {
            view?.reloadData() // Метод для перезагрузки данных в коллекции
        } else {
            view?.deleteItem(at: indexPath) // Метод для удаления элемента
//            coreData.deleteLikeBook(from: book[indexPath.row])
            coreData.deleteLikeBook(from: Work(key: nil, title: nil, coverEditionKey: nil, cover_i: nil, authorName: nil))
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard let selectedBook = book else { return }
        view?.openProduct(with: selectedBook[indexPath.row])
    }
}
