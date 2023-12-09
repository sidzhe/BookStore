//
//  ViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class TabBarController: UITabBarController, TabBarViewProtocol {
    
    //MARK: - Properties
    var presenter: TabBarPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        createTabBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 90
        tabBar.itemPositioning = .centered
        
    }
    
    //MARK: - GenerateVC
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = UINavigationController(rootViewController: viewController)
        return vc
    }
    
    
    //MARK: - SetupTabBar
    private func setupTabBar() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
//        appearance.stackedLayoutAppearance.normal.iconColor = .black
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        appearance.selectionIndicatorTintColor = .red
//        UITabBar.appearance().tintColor = appearance.selectionIndicatorTintColor
//        tabBar.scrollEdgeAppearance = appearance
//        tabBar.tintColor = .black
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = .purple
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = appearance.selectionIndicatorTintColor
    }
    
    
    //MARK: - CreateTabBar
    private func createTabBar() {
        let homeVC = Builder.createHomeVC()
        let categoriesVC = Builder.createCategoriesVC()
        let favoritesVC = Builder.createFavoritesVC()
        let accountVC = Builder.createAccountVC()
        
        viewControllers = [
            generateVC(homeVC, "Home", UIImage(systemName: "house")),
            generateVC(categoriesVC, "Categories", UIImage(systemName: "square.grid.3x3.middle.filled")),
            generateVC(favoritesVC, "Likes", UIImage(systemName: "heart.fill")),
            generateVC(accountVC, "Account", UIImage(systemName: "person.circle.fill"))
        ]
    }
}
