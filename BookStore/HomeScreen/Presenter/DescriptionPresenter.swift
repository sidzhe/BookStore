//
//  DescriptionPresenter.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

protocol DescriptionViewProtocol: AnyObject {
    func updateWithData(book: BookModel?)
}

protocol DescriptionPresenterProtocol: AnyObject {
    init(view: DescriptionViewProtocol)
}

final class DescriptionPresenter: DescriptionPresenterProtocol {

    weak var view: DescriptionViewProtocol?
    
    func updateData() {
        
    }
    
    init(view: DescriptionViewProtocol) {
        self.view = view
        
    }
    
    
}
