//
//  CategoriesPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol CategoriesViewProtocol: AnyObject {
    
}

protocol CategoriesPresenterProtocol: AnyObject {
    var currentText: String? { get set }
    var categoriesModel: [String] { get }
    init(view: CategoriesViewProtocol)
    func filteredPairs(with filter: String?) -> [String] 
}

//MARK: - CategoriesPresenter
final class CategoriesPresenter: CategoriesPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CategoriesViewProtocol?
    var currentText: String?
    var categoriesModel = BookCategories.allCases.map { $0.rawValue }
    
    //MARK: - Init
    required init(view: CategoriesViewProtocol) {
        self.view = view
    }
    
    //MARK: - Methods
    func filteredPairs(with filter: String?) -> [String] {
        guard let filter = filter, !filter.isEmpty else { return categoriesModel }
        let data = categoriesModel.filter({ $0.contains(filter) })
        return data
    }
}
