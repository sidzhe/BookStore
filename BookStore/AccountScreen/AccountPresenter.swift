//
//  AccountPresenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol AccountViewProtocol: AnyObject {
    
}

protocol AccountPresenterProtocol: AnyObject {
    init(view: AccountViewProtocol)
}

protocol ListViewControllerProtocol: AnyObject {
    
}

protocol ListViewControllerPresenterProtocol: AnyObject {
    init(view: ListViewControllerProtocol)
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

//MARK: - ListProtocol

//final class ListPresenter: ListViewControllerProtocol {
//    weak var view: ListViewControllerProtocol?
//    required init(view: ListViewControllerProtocol)
//    self.view = view
//}


