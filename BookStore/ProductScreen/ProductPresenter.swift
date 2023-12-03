//
//  ProductPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol ProductViewProtocol: AnyObject {
    
}

protocol ProductPresenterProtocol: AnyObject {
    init(view: ProductViewProtocol)
}

//MARK: - ProductPresenter
final class ProductPresenter: ProductPresenterProtocol {
    
    //MARK: - Properties
    weak var view: ProductViewProtocol?
    
    //MARK: - Init
    required init(view: ProductViewProtocol) {
        self.view = view
    }
}
