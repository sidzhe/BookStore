//
//  HomePresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol HomeViewProtocol: AnyObject {
    
}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    
    //MARK: - Init
    required init(view: HomeViewProtocol) {
        self.view = view
    }
}
