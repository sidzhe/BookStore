//
//  Presenter.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import Foundation

//MARK: - Protocols
protocol WelcomeViewProtocol: AnyObject {}

protocol WelcomePresenterProtocol: AnyObject {
    var onboardingText: [String] { get }
    init(view: WelcomeViewProtocol)
    func safeUserDefaults()
}

//MARK: - WelcomePresenter
final class WelcomePresenter: WelcomePresenterProtocol {
    
    //MARK: - Properties
    weak var view: WelcomeViewProtocol?
    var onboardingText = ["Read more and stress less with our online book shopping app.", "Shop from anywhere you are and discover titles that you love.", "Happy reading!"]
    
    //MARK: - Init
    required init(view: WelcomeViewProtocol) {
        self.view = view
    }
    
    func safeUserDefaults() {
        let state = true
        UserDefaults.standard.set(state, forKey: "state")
    }
}

