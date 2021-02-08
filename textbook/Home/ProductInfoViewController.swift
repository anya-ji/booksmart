//
//  ProductInfoViewController.swift
//  textbook
//
//  Created by Zuhao Hua on 12/6/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit



class ProductInfoViewController: UIViewController {
    
    private let productInfoView = ProductInfoView()
    
    init(inputBook:Book){
        super.init(nibName: nil, bundle: nil)
        
        productInfoView.configure(inputBookData: inputBook)
        productInfoView.chatDelegate = self
//        productInfoView.loadingDelegate = self
        view = productInfoView
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ProductInfoViewController: ShowChatProtocol{
    func showChat(inputBook: Book, buyer: UserInfo, seller: UserInfo, messages: [Message]) {
        let vc = ChatViewController(currentUser: buyer, otherUser: seller, book: inputBook, messages: messages)
        navigationController?.pushViewController(vc, animated: true)
    }
}

