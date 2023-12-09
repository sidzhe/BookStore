//
//  FavoritesPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

struct BookModel: Hashable {
    let genre: String
    let bookName: String
    let author: String
}

//MARK: - Protocols
protocol FavoritesViewProtocol: AnyObject {
    //Удаление ячейки
    func deleteItem(at indexPath: IndexPath)
    //Обновление UI коллекции
    func reloadData()
}

protocol FavoritesPresenterProtocol: AnyObject {
    var models: [BookModel] { get set }
    //Получение книги
    func getBook(with indexPath: IndexPath) -> BookModel
    //Удаление ячейки
    func removeItem(at indexPath: IndexPath)
    init(view: FavoritesViewProtocol)
}

//MARK: - FavoritesPresenter
final class FavoritesPresenter: FavoritesPresenterProtocol {

    //MARK: - Properties
    weak var view: FavoritesViewProtocol?
    
    var models: [BookModel] =
    [.init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
    ]
    
    //Логика получения книги
    func getBook(with indexPath: IndexPath) -> BookModel {
        return models[indexPath.row]
    }
    //Логика удаления ячейки
    func removeItem(at indexPath: IndexPath) {
            guard indexPath.row < models.count else { return }

            // Сообщаем контроллеру о необходимости обновления
            if models.isEmpty {
                view?.reloadData() // Метод для перезагрузки данных в коллекции
            } else {
                view?.deleteItem(at: indexPath) // Метод для удаления элемента
            }
        }
    

    //MARK: - Init
    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
}
