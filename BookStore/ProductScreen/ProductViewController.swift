//
//  ProductViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class ProductViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: ProductPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
    }
}


//MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    
}
