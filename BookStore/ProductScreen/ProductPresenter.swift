//
//  ProductPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol ProductViewProtocol: AnyObject {
    func setDetail()
    func failure(error: Error)
    func getURL(_ urlString: String?)
    func setLikeButtonState(_ isLiked: Bool)
}

protocol ProductPresenterProtocol: AnyObject {
    var details: BooksDetail? { get set }
    var rating: Double? { get set }
    var book: Work? { get set }
    var bookCoreData: LikedBooks? { get set }
    
    init(view: ProductViewProtocol, networkService: NetworkServiceProtocol, book: Work)
    func didTapAddToListButton()
    func didTapReadButton()
    func didTapLikeButton()
    func deleteLikedBook()
    func checkIfBookIsLiked()
    func setDetail()
}

//MARK: - ProductPresenter
final class ProductPresenter {
    
    //MARK: - Properties
    weak var view: ProductViewProtocol?
    let networkService: NetworkServiceProtocol
    var details: BooksDetail?
    var book: Work?
    var rating: Double?
    var bookCoreData: LikedBooks?
    var coreDataManager = CoreDataManager.shared
    
    //MARK: - Init
    
    required init(view: ProductViewProtocol, networkService: NetworkServiceProtocol, book: Work) {
        self.view = view
        self.networkService = networkService
        self.book = book
        saveRecent()
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    
    func checkIfBookIsLiked() {
        guard let book = book else { return }
        let isLiked = coreDataManager.isBookLiked(bookKey: book.key ?? "")
        view?.setLikeButtonState(isLiked)
    }

    func didTapLikeButton() {
        guard let book = book else { return }
        print("Like")
        coreDataManager.saveLikedBook(from: book)
    }

    func deleteLikedBook() {
        guard let book = book else { return }
        print("Unlike")
        coreDataManager.deleteLikeBook(from: book)
    }
    
    func didTapAddToListButton() {
        print("Add to list")
    }
    
    func didTapReadButton()  {
        guard let key = book?.key?.components(separatedBy: "/")[2] else { return }
        getArch(id: key)
    }
    
    func setDetail() {
        networkService.getDetailBook(key: book?.key ?? "") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let details):
                    self.details = details
                    self.getRating()
                    self.view?.setDetail()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getRating() {
        networkService.getRating(works: book?.key ?? "") { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let rating):
                    self.rating = rating.summary.average
                    self.view?.setDetail()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func getArch(id: String) {
        networkService.searchArchiveBooks(query: id) { [weak self] (result: Result<ReadingModel, Error>) in
            switch result {
            case .success(let res):
                let urlKey = res.response?.docs?.first?.identifier
                self?.view?.getURL(urlKey)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveRecent() {
        guard let book = book else { return }
        CoreDataManager.shared.saveBook(from: book)
    }
}
