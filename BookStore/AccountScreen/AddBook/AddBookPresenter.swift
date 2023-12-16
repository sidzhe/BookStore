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
    var book: [Book]? { get set }
    init(view: AddBookViewProtocol, networkService: NetworkServiceProtocol)
    func searchRequest(keyWords: String)
}

//MARK: - FavoritesPresenter
final class AddBookPresenter: AddBookPresenterProtocol {
    
    //MARK: - Properties
    weak var view: AddBookViewProtocol?
    var networkService: NetworkServiceProtocol
    var book: [Book]?
    
    //MARK: - Init
    required init(view: AddBookViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
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
