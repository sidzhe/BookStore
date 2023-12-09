import Foundation


//MARK: - Protocols
protocol SearchViewProtocol: AnyObject {
    //Обновление UI коллекции
    func reloadData()
}

protocol SearchPresenterProtocol: AnyObject {
    var books: [Book]? { get }
    var text: String? { get }
    func update(_ text: String)
    func getBook(at indexPath: IndexPath) -> Book?
    //Получение книги
    init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, text: String)
}

//MARK: - FavoritesPresenter
final class SearchPresenter: SearchPresenterProtocol {
    //MARK: - Properties
    weak var view: SearchViewProtocol?
    var networkService: NetworkServiceProtocol
    var books: [Book]?
    var text: String?

    required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, text: String) {
        self.view = view
        self.networkService = networkService
        self.text = text
        update(text)
    }

    
    func update(_ text: String) {
        print("запроc ушел")
        networkService.searchBooks(keyWords: text) { (result: Result<Books, Error>) in
            print("Запрос ушел с текстом - \(text)")
            DispatchQueue.main.async {
                switch result {
                case .success(let book):
                    print("Успех")
                    if let books = book.books {
                        self.books = self.tenthElement(books)
                    }
//                    self.books = tenthElement(book.books)
                    self.view?.reloadData()
                    if let books = self.books {
                        print(books[0].authorName)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getBook(at indexPath: IndexPath) -> Book? {
        return books?[indexPath.row]
    }
    
    func tenthElement(_ array: [Book]) -> [Book] {
        var books = [Book]()
        array.forEach {
            if books.count != 10 {
                books.append($0)
            }
        }
        return books
    }

}
