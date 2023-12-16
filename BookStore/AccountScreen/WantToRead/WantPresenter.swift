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
    var models: [BookModel] { get set }
    func getBook(with indexPath: IndexPath) -> BookModel
    func removeItem(at indexPath: IndexPath)
    init(view: WantViewProtocol)
}

//MARK: - FavoritesPresenter
final class WantPresenter: WantPresenterProtocol {

    //MARK: - Properties
    weak var view: WantViewProtocol?
    
    var models: [BookModel] =
    [.init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
     .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
    ]
    
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
    

    //MARK: - Init
    required init(view: WantViewProtocol) {
        self.view = view
    }
}
