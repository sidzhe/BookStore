//
//  ProductPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol ProductViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol ProductPresenterProtocol: AnyObject {
    var details: BooksDetail? { get set }
    var rating: Double? { get set }
    
    init(view: ProductViewProtocol, networkService: NetworkServiceProtocol)
    func didTapAddToListButton()
    func didTapReadButton()
    func getDetail()
}

//MARK: - ProductPresenter
final class ProductPresenter {
    
    //MARK: - Properties
    weak var view: ProductViewProtocol?
    let networkService: NetworkServiceProtocol
    var details: BooksDetail?
    var rating: Double?
    
    //MARK: - Init
    
    required init(view: ProductViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        
        getDetail()
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    
    func didTapAddToListButton() {
        print("Add to list")
    }
    
    func didTapReadButton() {
        print("Read")
    }
    
    func getDetail() {
        networkService.getDetailBook(key: "/books/OL22927024M") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self.details = details
                    self.getRating()
                    self.view?.success()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getRating() {
        networkService.getRating(works: details?.works[0].key ?? "") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let rating):
                    self.rating = rating.summary.average
                    self.view?.success()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
