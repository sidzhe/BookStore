//
//  Preseneter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol TabBarViewProtocol: AnyObject {}

protocol TabBarPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
}

//MARK: - TabBarPresenter
final class TabBarPresenter: TabBarPresenterProtocol {
    
    //MARK: - Properties
    weak var view: TabBarViewProtocol?
    
    //MARK: - Init
    required init(view: TabBarViewProtocol) {
        self.view = view
    }
}
