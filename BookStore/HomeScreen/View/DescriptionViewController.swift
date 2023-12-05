//
//  DescriptionViewController.swift
//  BookStore
//
//  Created by macbook on 05.12.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    var presenter: DescriptionPresenter!
    
    private let nameLabel = UILabel(font: .boldSystemFont(ofSize: 24))
    private let image = UIImageView()
    private let authorLabel = UILabel(font: .systemFont(ofSize: 14))
    private let categoryLabel = UILabel(font: .systemFont(ofSize: 14))
    private let ratingLabel = UILabel(font: .systemFont(ofSize: 14))
    private let descriptionLabel = UILabel(font: .boldSystemFont(ofSize: 14))
    private let textView = UITextView()
    
    private lazy var stackView = UIStackView(.vertical, 5, .fill, .equalSpacing, [authorLabel, categoryLabel, ratingLabel])
    
    var currentModel: BookModel?
    
    init(book: BookModel) {
        super.init(nibName: nil, bundle: nil)
        self.currentModel = book
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: "book")!
        setupView()
        setupConst()
        if let model = currentModel {
            authorLabel.text = model.author
            categoryLabel.text = model.genre
            nameLabel.text = model.bookName
        }
        
    }
    
    private func setupView() {
        view.addSubViews(nameLabel, stackView, descriptionLabel, textView, image)
        nameLabel.text = "The Picture of Dorian Gray"
        descriptionLabel.text = "Description:"
        authorLabel.text = "Author: Oscar Wilde"
        categoryLabel.text = "Category: Classic"
        ratingLabel.text = "Rating: 5/5"
        textView.font = .systemFont(ofSize: 14)
        textView.text = "Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise: As Dorian Gray sinks into a life of crime and gross sensuality, his body retains perfect youth and vigor while his recently painted portrait grows day by day into a hideous record of evil, which he"
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        view.backgroundColor = .white
        
    }
    
    private func setupConst() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 26),
            
            image.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            image.heightAnchor.constraint(equalToConstant: 220),
            image.widthAnchor.constraint(equalToConstant: 175),
            
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 34),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            
            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 17),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension DescriptionViewController: DescriptionViewProtocol {
    func updateWithData(book: BookModel?) {
        nameLabel.text = book?.bookName
        authorLabel.text = book?.author
        categoryLabel.text = book?.genre
    }
    
    
}

////MARK: - SwiftUI
//import SwiftUI
//struct Provider_DescriptionViewController : PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//    
//    struct ContainterView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            return DescriptionViewController()
//        }
//        
//        typealias UIViewControllerType = UIViewController
//        
//        
//        let viewController = DescriptionViewController()
//        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_DescriptionViewController.ContainterView>) -> DescriptionViewController {
//            return viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: Provider_DescriptionViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_DescriptionViewController.ContainterView>) {
//            
//        }
//    }
//    
//}
