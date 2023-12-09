//
//  Extensions.swift
//  BookStore
//
//  Created by Лилия Феодотова on 08.12.2023.
//

import UIKit

//MARK: - UIView Extension

extension UIView {
    func disableSubviewsTamic() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}

extension UIViewController {
    func setNavigation(title: String){
        navigationItem.hidesBackButton = true
        navigationItem.title = title
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
