//
//  NetworkService.swift
//  BookStore
//
//  Created by Лилия Феодотова on 04.12.2023.
//

import Foundation

//MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func searchBooks(keyWords: String, completion: @escaping (Result<Books, Error>) -> Void)
    func getTrendingBooks(sort: TrendingSort, completion: @escaping (Result<[Work], Error>) -> Void)
    func getRating(works: String, completion: @escaping (Result<Rating, Error>) -> Void)
    func getDetailBook(key: String, completion: @escaping (Result<BooksDetail, Error>) -> Void)
    func getBooksByCategories(category: BookCategories, completion: @escaping (Result<[Work], Error>) -> Void)
}


//MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {
    
    ///Trending
    func getTrendingBooks(sort: TrendingSort, completion: @escaping (Result<[Work], Error>) -> Void) {
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
    
    ///Search
    func searchBooks(keyWords: String, completion: @escaping (Result<Books, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "openlibrary.org"
        components.path = "/search.json"
        components.queryItems = [URLQueryItem(name: "q", value: "\(keyWords)"), URLQueryItem(name: "limit", value: "10")]
        guard let url = components.url else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Books.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    ///Rating
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
    
    ///Detail
    
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
    
    ///Categories
    func getBooksByCategories(category: BookCategories, completion: @escaping (Result<[Work], Error>) -> Void) {
        guard let url = URL(string: NetworkConstants.baseUrl + Endpoint.subjects.rawValue + category.rawValue + ".json") else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(BooksByCategories.self, from: data)
                completion(.success(result.works))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
