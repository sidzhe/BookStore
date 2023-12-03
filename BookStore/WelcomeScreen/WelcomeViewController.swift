//
//  WelcomeViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: WelcomePresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
    }
}

//MARK: - WelcomePresenterProtocol
extension WelcomeViewController: WelcomeViewProtocol {
    
}
