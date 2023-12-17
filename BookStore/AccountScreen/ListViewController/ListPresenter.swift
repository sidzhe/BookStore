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
    func saveList(listName: String)
}

//MARK: - AccountPresenter
final class ListPresenter: ListPresenterProtocol {
    
    //MARK: - Properties
    weak var view: ListViewProtocol?
    var data: [String] = []
    
    //MARK: - Init
    required init(view: ListViewProtocol) {
        self.view = view
        loadList()

    }
    
    func saveList(listName: String) {
        CoreDataManager.shared.saveList(listName: listName)
    }
    
    private func loadList() {
        guard let list = CoreDataManager.shared.loadList(), !list.isEmpty else { return }
        data = list
    }
}
