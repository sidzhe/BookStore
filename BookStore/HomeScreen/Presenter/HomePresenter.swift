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
    //Change contentView color in cells
    func didSelectItemAt(at indexPath: IndexPath, isSelected: Bool)
    //Select cells logic
    func didSelectItemAt(at indexPath: IndexPath)

}

protocol HomePresenterProtocol: AnyObject {
    //Models
    var topBooks: [BookModel] { get set }
    var recentBooks: [BookModel] { get set }
    var times: [TimeModel] { get set }
    //Changes in SearchBar
    func didTextChange(_ text: String)
    //Button tapped in SearchBar
    func didTapSearchButton(_ text: String)
    //Select cell in CollectionView
    func didSelectItemAt(_ indexPath: IndexPath)
    func didSelectItem(_ indexPath: IndexPath)
    init(view: HomeViewProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    private var lastSelectedIndexPath: IndexPath?
    //Мок данные
   var topBooks: [BookModel] = [
        .init(genre: "classic", bookName: "The picture of Dorian Gray", author: "Oscar Wilde"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
        .init(genre: "classic", bookName: "The Catcher in the Rye", author: "J.D. Salinger"),
    ]
    
     var recentBooks: [BookModel] = [
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Fantasy", bookName: "Sorrow and Starlight", author: "Caroline Peckham, Susanne Valenti"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),
        .init(genre: "Young adult", bookName: "Nine Liars", author: "Maureen Johnson"),

    ]
    
     var times: [TimeModel] = [
        .init(times: "This Week"),
        .init(times: "This Month"),
        .init(times: "This Year")
    ]
    
 
 
    //MARK: - CollectionView Delegate
    
    //Change color method
    func didSelectItemAt(_ indexPath: IndexPath) {
        // Сообщить View об изменении состояния предыдущей выбранной ячейки
        if let lastIndexPath = lastSelectedIndexPath {
            view?.didSelectItemAt(at: lastIndexPath, isSelected: false)
        }
        // Обновить текущую выбранную ячейку и изменить её внешний вид
        lastSelectedIndexPath = indexPath
        view?.didSelectItemAt(at: indexPath, isSelected: true)
    }
     //Selected item logic
    func didSelectItem(_ indexPath: IndexPath) {
        view?.didSelectItemAt(at: indexPath)
    }
    
    //SearchBar Delegate
    func didTextChange(_ text: String) {
    }
    //Search button logic
    func didTapSearchButton(_ text: String) {
        print(text)
    }
    
    
    
    //MARK: - Init
    required init(view: HomeViewProtocol) {
        self.view = view
    }
}

