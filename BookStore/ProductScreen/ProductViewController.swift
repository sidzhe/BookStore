//
//  ProductViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class ProductViewController: UIViewController {
    
    //MARK: - Presenter
    var presenter: ProductPresenterProtocol!
    private let productView: IProductView
    
    init(productView: IProductView) {
        self.productView = productView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewDidLoad
    override func loadView() {
        view = productView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productView.addToListButton.addTarget(self, action: #selector(addToListButtonTapped), for: .touchUpInside)
        productView.readButton.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
    }
}


//MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    func success() {
        guard let details = presenter.details else { return }
        configure(details: details)
        guard let rating = presenter.rating else { return }
        configureRating(rating: rating)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - private Methods
private extension ProductViewController {
    @objc func addToListButtonTapped() {
        presenter.didTapAddToListButton()
    }
    
    @objc func readButtonTapped() {
        presenter.didTapReadButton()
    }
    
    func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
        ]
        let attrStr = NSMutableAttributedString(string: string, attributes: boldAttribute)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    
    func configureRating(rating: Double) {
        let ratingTitle = "Rating : " + String(describing: rating) + "/5"
        let ratingRange = NSMakeRange(0, "Rating :".count)
        productView.rating.attributedText = attributedString(from: ratingTitle, nonBoldRange: ratingRange)
    }
    
    func configure(details: BooksDetail) {
        productView.booksName.text = details.title
        let authorTitle = "Author : " + details.byStatement
        let categoryTitle = "Category : " + details.genres[0]
        
        
        let authorRange = NSMakeRange(0, "Author :".count)
        productView.author.attributedText = attributedString(from: authorTitle, nonBoldRange: authorRange)
        
        let categoryRange = NSMakeRange(0, "Category :".count)
        productView.category.attributedText = attributedString(from: categoryTitle, nonBoldRange: categoryRange)
        
        productView.imageBook.kf.setImage(with: details.urlImage)
        productView.booksDescription.text = details.description.value
    }
}

//MARK: - UIView Extension

extension UIView {
    func disableSubviewsTamic() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
}
