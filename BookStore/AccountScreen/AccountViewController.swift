//
//  AccountViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class AccountViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: AccountPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
    }
}


//MARK: - AccountViewProtocol
extension AccountViewController: AccountViewProtocol {
    
}
