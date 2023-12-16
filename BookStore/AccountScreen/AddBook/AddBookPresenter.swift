//
//  AddBookPresenter.swift
//  BookStore
//
//  Created by sidzhe on 16.12.2023.
//

import Foundation

//MARK: - Protocols
protocol AddBookViewProtocol: AnyObject {
    func update()
}

protocol AddBookPresenterProtocol: AnyObject {
    var title: String { get }
    var book: [Book]? { get set }
    init(view: AddBookViewProtocol, networkService: NetworkServiceProtocol, title: String)
    func searchRequest(keyWords: String)
}

//MARK: - FavoritesPresenter
final class AddBookPresenter: AddBookPresenterProtocol {
    
    //MARK: - Properties
    weak var view: AddBookViewProtocol?
    var networkService: NetworkServiceProtocol
    var book: [Book]?
    var title: String
    
    //MARK: - Init
    required init(view: AddBookViewProtocol, networkService: NetworkServiceProtocol, title: String) {
        self.view = view
        self.networkService = networkService
        self.title = title
    }
    
    //MARK: - SearchRequest
    func searchRequest(keyWords: String) {
        networkService.searchBooks(keyWords: keyWords) { [weak self] result in
            switch result {
            case .success(let data):
                self?.book = data.books
                DispatchQueue.main.async { self?.view?.update() }
            case .failure(let error):
                print("search error, \(error.localizedDescription)")
            }
        }
    }
}
