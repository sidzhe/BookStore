//
//  ListCell.swift
//  BookStore
//
//  Created by sidzhe on 16.12.2023.
//

import UIKit
import SnapKit

final class ListCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let id = "ListCellId"
    
    //MARK: - UI Elements
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.tintColor = .black
        return arrow
    }()
    
    private lazy var labelButton: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupViews() {
        backgroundColor = .systemGray5
        clipsToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray3.cgColor
        
        contentView.addSubview(labelButton)
        contentView.addSubview(arrow)
        
        labelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.size.equalTo(20)
        }
    }
    
    //MARK: - Configure
    func configure(_ model: String) {
        labelButton.text = model
    }
}
