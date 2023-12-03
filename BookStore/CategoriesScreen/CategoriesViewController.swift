//
//  CategoriesViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: CategoriesPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
        
    }
}


//MARK: - CategoriesViewProtocol
extension CategoriesViewController: CategoriesViewProtocol {
    
}
