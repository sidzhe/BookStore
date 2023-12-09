import Foundation


//MARK: - Protocols
protocol SearchViewProtocol: AnyObject {
    //Удаление ячейки
    func deleteItem(at indexPath: IndexPath)
    //Обновление UI коллекции
    func reloadData()
}

protocol SearchPresenterProtocol: AnyObject {
    var books: [Books]? { get }
    //Получение книги
    func getBook(with indexPath: IndexPath) -> Books?
    //Удаление ячейки
    func removeItem(at indexPath: IndexPath)
    init(view: SearchViewProtocol, networkService: NetworkServiceProtocol)
}

//MARK: - FavoritesPresenter
final class SearchPresenter: SearchPresenterProtocol {
    

    
    //MARK: - Properties
    weak var view: SearchViewProtocol?
    var networkService: NetworkServiceProtocol
    var books: [Books]?

    required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }

    //Логика получения книги
    func getBook(with indexPath: IndexPath) -> Books? {
        return books?[indexPath.row]
    }

    //Логика удаления ячейки
    func removeItem(at indexPath: IndexPath) {
        if let books = books {
            guard indexPath.row < books.count else { return }
        }
            // Сообщаем контроллеру о необходимости обновления
        if books == nil {
                view?.reloadData() // Метод для перезагрузки данных в коллекции
            } else {
                view?.deleteItem(at: indexPath) // Метод для удаления элемента
            }
        }
    


}
