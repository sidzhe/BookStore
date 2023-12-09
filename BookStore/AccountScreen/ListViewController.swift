//
//  ListViewController.swift
//  BookStore
//
//  Created by Федор Игонин on 07.12.2023.
//

import UIKit

class ListViewController: UIViewController, UITextFieldDelegate {
    
    let wantToRead = UITextField()
    let classicBooks = UITextField()
    let readForFun = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initialize() {
        wantToRead.backgroundColor = .lightGray
        wantToRead.borderStyle = .roundedRect
        wantToRead.delegate = self
        view.addSubview(wantToRead)
        wantToRead.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(300)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            wantToRead.placeholder = "Lists"
        }
        classicBooks.backgroundColor = .lightGray
        classicBooks.borderStyle = .roundedRect
        classicBooks.delegate = self
        view.addSubview(classicBooks)
        classicBooks.snp.makeConstraints { make in
            make.top.equalTo(wantToRead.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            wantToRead.placeholder = "Lists"
        }
        readForFun.backgroundColor = .lightGray
        readForFun.borderStyle = .roundedRect
        readForFun.delegate = self
        view.addSubview(readForFun)
        readForFun.snp.makeConstraints { make in
            make.top.equalTo(classicBooks.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            readForFun.placeholder = "Lists"
        }
    }
    

    

}
