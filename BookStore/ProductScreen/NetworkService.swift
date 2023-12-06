//
//  NetworkService.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import Foundation

enum NetworkConstants {
    static let baseUrl = "https://openlibrary.org"
    static let imageCover = "https://covers.openlibrary.org/b/id"
}

enum Endpoint: String {
    case search = "/search.json?q="
    case trending = "/trending"
    case ratings = "/ratings"
}

enum TrendingSort: String {
    case daily = "/daily"
    case weekly = "/weekly"
    case monthly = "/monthly"
}

protocol NetworkServiceProtocol {
    func searchBooks(keyWords: String, completion: @escaping (Result<[Book], Error>) -> Void)
//    func getCategories(completion: @escaping (Result<[Book], Error>) -> Void))
    func getTrendingBooks(sort: TrendingSort, completion: @escaping (Result<[Work], Error>) -> Void)
    func getDetailBook(key: String, completion: @escaping (Result<BooksDetail, Error>) -> Void)
    func getRating(works: String, completion: @escaping (Result<Rating, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getTrendingBooks(sort: TrendingSort = .daily, completion: @escaping (Result<[Work], Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.baseUrl + Endpoint.trending.rawValue + sort.rawValue + ".json") else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(TrendBooks.self, from: data)
                completion(.success(result.works))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func searchBooks(keyWords: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        let keyWordsReplace = keyWords.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: NetworkConstants.baseUrl + Endpoint.search.rawValue + keyWordsReplace) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Books.self, from: data)
                completion(.success(results.docs))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getRating(works: String, completion: @escaping (Result<Rating, Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.baseUrl + works + Endpoint.ratings.rawValue + ".json") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(Rating.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDetailBook(key: String, completion: @escaping (Result<BooksDetail, Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.baseUrl + key + ".json") else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(BooksDetail.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
