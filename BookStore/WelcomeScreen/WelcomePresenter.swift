//
//  Presenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol WelcomeViewProtocol: AnyObject {
    
}

protocol WelcomePresenterProtocol: AnyObject {
    init(view: WelcomeViewProtocol)
}

//MARK: - WelcomePresenter
final class WelcomePresenter: WelcomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: WelcomeViewProtocol?
    
    //MARK: - Init
    required init(view: WelcomeViewProtocol) {
        self.view = view
    }
}
