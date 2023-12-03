//
//  FavoritesViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: FavoritesPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
    }
}


//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    
}
