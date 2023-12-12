import Foundation


//MARK: - Protocols
protocol SearchViewProtocol: AnyObject {
    //Обновление UI коллекции
    func reloadData()
    func animating(_ start: Bool)
}

protocol SearchPresenterProtocol: AnyObject {
    var books: [Book]? { get }
    var text: String? { get }
    func requestSearch(_ text: String)
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
        requestSearch(text)
    }
    
    func requestSearch(_ text: String) {
        networkService.searchBooks(keyWords: text) { [weak self] (result: Result<Books, Error>) in
            guard let self = self else { return }
            self.view?.animating(true)
            switch result {
            case .success(let book):
                self.books = book.books
                DispatchQueue.main.async {
                    self.view?.animating(false)
                    self.view?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
