//
//  HomePresenter.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

//MARK: - Protocols
protocol HomeViewProtocol: AnyObject {
    func updateWithData(topBooks: [BookModel], recentBooks: [BookModel], times: [TimeModel])
    func updateCellAppearance(at indexPath: IndexPath, isSelected: Bool)

}

protocol HomePresenterProtocol: AnyObject {
    init(view: HomeViewProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    private var lastSelectedIndexPath: IndexPath?
    //Мок данные
   let topBooks: [BookModel] = [
        .init(genre: "classic", bookName: "The picture of Dorian Gray", author: "Oscar Wilde"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
    ]
    
     let recentBooks: [BookModel] = [
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Fantasy", bookName: "Sorrow and Starlight", author: "Caroline Peckham, Susanne Valenti"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),

    ]
    
     let times: [TimeModel] = [
        .init(times: "This Week"),
        .init(times: "This Month"),
        .init(times: "This Year")
    ]
    
 
 
    //CollectionView Delegate
    func didSelectItemAt(_ indexPath: IndexPath) {
        // Сообщить View об изменении состояния предыдущей выбранной ячейки
        if let lastIndexPath = lastSelectedIndexPath {
            view?.updateCellAppearance(at: lastIndexPath, isSelected: false)
        }
        // Обновить текущую выбранную ячейку и изменить её внешний вид
        lastSelectedIndexPath = indexPath
        view?.updateCellAppearance(at: indexPath, isSelected: true)
    }
    
    //SearchBar Delegate
    func didTextChange(_ text: String) {
    }
    
    func didTapSearchButton(_ text: String) {
        print(text)
    }
    
    
    
    //MARK: - Init
    required init(view: HomeViewProtocol) {
        self.view = view
    }
}

