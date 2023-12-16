//
//  HomePresenter.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import Foundation

//MARK: - Protocols
protocol HomeViewProtocol: AnyObject {
    func update()
    func animatig(_ start: Bool)
    func setupLabel()
}

protocol HomePresenterProtocol: AnyObject {
    var topBooks: [Work]? { get }
    var recentBooks: [Work]? { get }
    var times: [TimeModel] { get set }
    var searhedBook: [Book]? { get }
    func viewDidLoad()
    func didSelectItemAt(_ indexPath: IndexPath)
    init(view: HomeViewProtocol, networkService: NetworkServiceProtocol)
}

//MARK: - HomePresenter
final class HomePresenter: HomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: HomeViewProtocol?
    var networkService: NetworkServiceProtocol
    var topBooks: [Work]?
    var recentBooks: [Work]?
    var searhedBook: [Book]?
    var times = [TimeModel(times: "This Week", isSelected: true), TimeModel(times: "This Month"), TimeModel(times: "This Year")]
    
    //MARK: - Init
    required init(view: HomeViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        timeBookRequest(sort: .daily)
    }
    
    func viewDidLoad() {
        timeBookRequest(sort: .daily)
    }
    
    // CollectionView Delegate
    func didSelectItemAt(_ indexPath: IndexPath) {
        for i in 0..<times.count {
            times[i].isSelected = false
        }
        
        times[indexPath.row].isSelected = !times[indexPath.row].isSelected
        
        let selectedTimeModel = times[indexPath.row]
        switch selectedTimeModel.times {
        case "This Week":
            timeBookRequest(sort: .daily)
        case "This Month":
            timeBookRequest(sort: .weekly)
        case "This Year":
            timeBookRequest(sort: .monthly)
        default:
            break
        }
    }
    
    //MARK: - Network Requeest
    func timeBookRequest(sort: TrendingSort) {
        self.view?.setupLabel()
        self.view?.animatig(true)
        networkService.getTrendingBooks(sort: sort) { [weak self] (result: Result<[Work], Error>) in
            switch result {
            case .success(let trendBooks):
                self?.topBooks = trendBooks
                self?.recentBooks = CoreDataManager.shared.getBook()
                DispatchQueue.main.async {
                    self?.view?.animatig(false)
                    self?.view?.update()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
