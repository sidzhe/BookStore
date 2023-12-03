//
//  FavoritesPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol FavoritesViewProtocol: AnyObject {
    
}

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol)
}

//MARK: - FavoritesPresenter
final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    //MARK: - Properties
    weak var view: FavoritesViewProtocol?
    
    //MARK: - Init
    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
}
