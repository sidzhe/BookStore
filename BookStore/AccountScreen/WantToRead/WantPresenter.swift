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
}

protocol WantPresenterProtocol: AnyObject {
    var title: String { get }
    var models: [BookModel] { get set }
    func getBook(with indexPath: IndexPath) -> BookModel
    func removeItem(at indexPath: IndexPath)
    init(view: WantViewProtocol, title: String)
}

//MARK: - FavoritesPresenter
final class WantPresenter: WantPresenterProtocol {

    //MARK: - Properties
    weak var view: WantViewProtocol?
    var title: String
    
    var models: [BookModel] =
    [.init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
    ]
    
    //MARK: - Init
    required init(view: WantViewProtocol, title: String) {
        self.view = view
        self.title = title
    }
    
    func getBook(with indexPath: IndexPath) -> BookModel {
        return models[indexPath.row]
    }

    func removeItem(at indexPath: IndexPath) {
            guard indexPath.row < models.count else { return }

            if models.isEmpty {
                view?.reloadData()
            } else {
                view?.deleteItem(at: indexPath)
            }
        }
}
