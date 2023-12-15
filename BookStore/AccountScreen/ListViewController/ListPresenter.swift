//
//  ListPresenter.swift
//  BookStore
//
//  Created by sidzhe on 15.12.2023.
//

//MARK: - Protocols
protocol ListViewProtocol: AnyObject {
    
}

protocol ListPresenterProtocol: AnyObject {
    var data: [String] { get set }
    init(view: ListViewProtocol)
}

//MARK: - AccountPresenter
final class ListPresenter: ListPresenterProtocol {
    
    //MARK: - Properties
    weak var view: ListViewProtocol?
    var data = ["Want to read", "Classic books", "Read for fun"]
    
    //MARK: - Init
    required init(view: ListViewProtocol) {
        self.view = view
    }
}
