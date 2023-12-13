//
//  CategoriesPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol CategoriesViewProtocol: AnyObject {}

protocol CategoriesPresenterProtocol: AnyObject {
    var currentText: String? { get set }
    var categoriesModel: [String] { get }
    init(view: CategoriesViewProtocol, netwrokService: NetworkServiceProtocol)
    func filteredPairs(with filter: String?) -> [String]
}

//MARK: - CategoriesPresenter
final class CategoriesPresenter: CategoriesPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CategoriesViewProtocol?
    var networkService: NetworkServiceProtocol
    var currentText: String?
    var categoriesModel = BookCategories.allCases.map { $0.rawValue }
    
    //MARK: - Init
    required init(view: CategoriesViewProtocol, netwrokService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = netwrokService
    }
    
    //MARK: - Methods
    func filteredPairs(with filter: String?) -> [String] {
        guard let filter = filter, !filter.isEmpty else { return categoriesModel }
        let data = categoriesModel.filter({ $0.contains(filter) })
        return data
    }
}
