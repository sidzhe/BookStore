//
//  AccountPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol AccountViewProtocol: AnyObject {}

protocol AccountPresenterProtocol: AnyObject {
    init(view: AccountViewProtocol)
}


//MARK: - AccountPresenter
final class AccountPresenter: AccountPresenterProtocol {
    
    //MARK: - Properties
    weak var view: AccountViewProtocol?
    
    //MARK: - Init
    required init(view: AccountViewProtocol) {
        self.view = view
    }
}


