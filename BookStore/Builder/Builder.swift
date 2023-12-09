//
//  Builder.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class Builder {
    
    private init() {}
    
    //TabBarVC
    static func createTabBar() -> UIViewController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    //WelcomeVC
    static func createWelcomeVC() -> UIViewController {
        let view = WelcomeViewController()
        let presenter = WelcomePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    //HomeVC
    static func createHomeVC() -> UIViewController {
        let view = HomeViewController()
        let networkService = NetworkService()
        let presenter = HomePresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    //SearchVC
    static func createSearchVC(with text: String) -> UIViewController {
        let view = SearchViewController()
        let text = text
        let networkService = NetworkService()
        let presenter = SearchPresenter(view: view, networkService: networkService, text: text)
        view.presenter = presenter
        return view
    }
    
    //CategoriesVC
    static func createCategoriesVC() -> UIViewController {
        let view = CategoriesViewController()
        let presenter = CategoriesPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    //ProductVC
    static func createProductVC(book: Work) -> UIViewController {
        let view = ProductViewController(productView: ProductView())
        let presenter = ProductPresenter(view: view, networkService: NetworkService(), book: book)
        view.presenter = presenter
        return view
    }
    
    //FavoritesVC
    static func createFavoritesVC() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    //AccountVC
    static func createAccountVC() -> UIViewController {
        let view = AccountViewController()
        let presenter = AccountPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
