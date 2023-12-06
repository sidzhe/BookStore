//
//  HomeViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: HomePresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
    }
}

//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
}
