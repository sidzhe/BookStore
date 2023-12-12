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
    func getBooksByCategories(category: String, completion: @escaping (Result<[Work], Error>) -> Void)
}


//MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {
    
    ///Trending
    func getTrendingBooks(sort: TrendingSort, completion: @escaping (Result<[Work], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseUrl
        components.path = "/trending/\(sort.rawValue).json"
        let items = [URLQueryItem(name: "limit", value: "10")]
        components.queryItems = items
        
        guard let url = components.url else { return }
        
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
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseUrl
        components.path = Endpoint.search.rawValue
        let items = [URLQueryItem(name: "q", value: "\(keyWords)"),
                     URLQueryItem(name: "fields", value: "key,title,author_name,cover_i,editions,editions.key,editions.title,editions.ebook_access,ratings_count,subtitle"), URLQueryItem(name: "has_fulltext", value: "true"), URLQueryItem(name: "limit", value: "10")]
        components.queryItems = items
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
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseUrl
        components.path = "/\(works)/ratings.json"
        
        guard let url = components.url else { return }
        
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
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseUrl
        components.path = "\(key).json"
        
        guard let url = components.url else { return }
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
    func getBooksByCategories(category: String, completion: @escaping (Result<[Work], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = NetworkConstants.scheme
        components.host = NetworkConstants.baseUrl
        components.path = "/subjects/\(category).json"
        components.queryItems = [URLQueryItem(name: "limit", value: "10")]
        
        guard let url = components.url else { return }
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
