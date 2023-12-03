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
    init(view: CategoriesViewProtocol)
}

//MARK: - CategoriesPresenter
final class CategoriesPresenter: CategoriesPresenterProtocol {
    
    //MARK: - Properties
    weak var view: CategoriesViewProtocol?
    
    //MARK: - Init
    required init(view: CategoriesViewProtocol) {
        self.view = view
    }
}
