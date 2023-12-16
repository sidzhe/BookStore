//
//  ProductViewController.swift
//  BookStore
//
//  Created by sidzhe on 03.12.2023.
//

import UIKit
import SnapKit
import Kingfisher
import SafariServices

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
        productView.likeButton.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        
        presenter.setDetail()
        presenter.checkIfBookIsLiked()
        setupNavigationBar()
    }
}

//MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    
    func setLikeButtonState(_ isLiked: Bool) {
        DispatchQueue.main.async {
            self.productView.likeButton.isSelected = isLiked
        }
    }
    
    func getURL(_ url: String?) {
        guard let url = URL(string: "https://archive.org/details/\(url ?? "")/mode/2up?view=theater") else { return }
        let safariViewController = SFSafariViewController(url: url)
        DispatchQueue.main.async { [weak self] in self?.present(safariViewController, animated: true) }
    }
    
    func setDetail() {
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
@objc private extension ProductViewController {
    func addToListButtonTapped() {
        presenter.didTapAddToListButton()
    }
    
    func readButtonTapped() {
        presenter.didTapReadButton()
    }
    
    func likeButtonTapped() {
        
    }
    
    func tapLike(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.isSelected ? presenter.didTapLikeButton() : presenter.deleteLikedBook()
        
        
    }
}
    private extension ProductViewController {
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
            let ratingTitle = "Rating : " + String(format: "%.02f", rating) + "/5"
            let ratingRange = NSMakeRange(0, "Rating :".count)
            productView.rating.attributedText = attributedString(from: ratingTitle, nonBoldRange: ratingRange)
        }
        
        func configure(details: BooksDetail) {
            productView.booksName.text = details.title
            let authorTitle = "Author : " + (presenter.book?.authorName?.first ?? "none")
            let categoryTitle = "Category : " + (details.subjects?.first ?? "none")
            
            
            let authorRange = NSMakeRange(0, "Author :".count)
            productView.author.attributedText = attributedString(from: authorTitle, nonBoldRange: authorRange)
            
            let categoryRange = NSMakeRange(0, "Category :".count)
            productView.category.attributedText = attributedString(from: categoryTitle, nonBoldRange: categoryRange)
            
            productView.imageBook.kf.setImage(with: details.urlImage)
            productView.booksDescription.text = details.description?.stringValue() ?? details.description?.createdValue()?.value ?? "Description is empty, sorry :("
            
            setupNavigationBar()
        }
        
        func setupNavigationBar() {
            setNavigation(title: presenter?.details?.subjects?.first ?? "")
        }
    }

