//
//  ProductInfoView.swift
//  textbook
//
//  Created by Zuhao Hua on 12/6/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//
import Foundation

import UIKit

protocol ShowChatProtocol: class {
    func showChat(inputBook:Book, buyer:UserInfo, seller: UserInfo, messages: [Message])
}

protocol ShowLoadingProtocol: class {
    func showLoading()
    func dismissLoading()
}

class ProductInfoView: UIView {
    
    var bookTitle: UILabel!
    var bookAuthor: UILabel!
    var bookEdition: UILabel!
    var bookISBN: UILabel!
    var saved: UIButton! // testing
    var bookPrice: UILabel!
    var bookCondition: UILabel!
    var bookClass: UILabel!
    var classLabel: UILabel!
    var bookImage: UIImageView!
    var sellerLabel: UILabel!
    var sellerName: UILabel!
    var sellerEmail: UILabel!
    var sellerImage: UIImageView!
    var addButton: UIButton!
    var bookID:Int!
    
    var book:Book!
    var seller: UserInfo!
    var buyer: UserInfo!
    
    var isSaved: Bool! = false
    
    weak var chatDelegate: ShowChatProtocol?
    weak var loadingDelegate: ShowLoadingProtocol?
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .white
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        
        bookTitle = UILabel()
        bookTitle.textColor = .black
        bookTitle.textAlignment = .left
        bookTitle.font = .systemFont(ofSize: 22, weight: .bold)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookTitle)
        
        bookAuthor = UILabel()
        bookAuthor.textColor = .black
        bookAuthor.textAlignment = .left
        bookAuthor.font = .systemFont(ofSize: 15, weight: .regular)
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookAuthor)
        
        bookEdition = UILabel()
        bookEdition.textColor = .black
        bookEdition.textAlignment = .left
        bookEdition.font = .systemFont(ofSize: 15, weight: .regular)
        bookEdition.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookEdition)
        
        bookISBN = UILabel()
        bookISBN.textColor = .black
        bookISBN.textAlignment = .left
        bookISBN.font = .systemFont(ofSize: 15, weight: .regular)
        bookISBN.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookISBN)
        
        saved = UIButton()
        saved.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saved.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saved)
        
        bookPrice = UILabel()
        bookPrice.textColor = .black
        bookPrice.textAlignment = .right
        bookPrice.font = .systemFont(ofSize: 22, weight: .bold)
        bookPrice.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookPrice)
        
        bookCondition = UILabel()
        bookCondition.textColor = .black
        bookCondition.textAlignment = .right
        bookCondition.font = .systemFont(ofSize: 18, weight: .regular)
        bookCondition.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookCondition)
        
        bookClass = UILabel()
        bookClass.textColor = .black
        bookClass.textAlignment = .left
        bookClass.font = .systemFont(ofSize: 18, weight: .regular)
        bookClass.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookClass)
        
        classLabel = UILabel()
        classLabel.textColor = .black
        classLabel.textAlignment = .left
        classLabel.font = .systemFont(ofSize: 18, weight: .regular)
        classLabel.text = "Used in "
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(classLabel)
        
        bookImage = UIImageView()
        bookImage.layer.cornerRadius = 20
        bookImage.clipsToBounds = true
        bookImage.image = UIImage()
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bookImage)
        
        sellerName = UILabel()
        sellerName.textColor = .black
        sellerName.textAlignment = .left
        sellerName.font = .systemFont(ofSize: 20, weight: .bold)
        sellerName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sellerName)
        
        sellerLabel = UILabel()
        sellerLabel.textColor = .black
        sellerLabel.textAlignment = .left
        sellerLabel.font = .systemFont(ofSize: 22, weight: .bold)
        sellerLabel.text = "About the seller "
        sellerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sellerLabel)
        
        sellerEmail = UILabel()
        sellerEmail.textColor = .lightGray
        sellerEmail.textAlignment = .left
        sellerEmail.font = .systemFont(ofSize: 15, weight: .regular)
        sellerEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sellerEmail)
        
        sellerImage = UIImageView()
        sellerImage.layer.cornerRadius = 25
        // temporary image, replace later
        sellerImage.image = UIImage(systemName: "person.circle")
        sellerImage.tintColor = UIColor.custom_aqua
        sellerImage.clipsToBounds = true
        sellerImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sellerImage)
        
        addButton = UIButton()
        addButton.layer.cornerRadius = 20
        addButton.clipsToBounds = true
        //        addButton.setTitle("Add to Cart", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .custom_pink
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Message Seller", for: .normal)
        self.addSubview(addButton)
        
    }
    
    func setupConstraints() {
        
        let padding: CGFloat = 25
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            bookTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bookTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 15),
            bookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bookImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            bookImage.bottomAnchor.constraint(equalTo: bookAuthor.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            bookAuthor.bottomAnchor.constraint(equalTo: sellerLabel.topAnchor, constant: -80),
            bookAuthor.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bookAuthor.widthAnchor.constraint(equalToConstant: 180),
            bookAuthor.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            bookEdition.topAnchor.constraint(equalTo: bookAuthor.bottomAnchor),
            bookEdition.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bookEdition.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            bookISBN.topAnchor.constraint(equalTo: bookEdition.bottomAnchor),
            bookISBN.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bookISBN.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            saved.topAnchor.constraint(equalTo: bookAuthor.topAnchor),
            saved.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            saved.heightAnchor.constraint(equalToConstant: 20),
            saved.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bookPrice.topAnchor.constraint(equalTo: saved.bottomAnchor),
            bookPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            bookPrice.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            bookCondition.topAnchor.constraint(equalTo: bookPrice.bottomAnchor),
            bookCondition.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            bookCondition.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            classLabel.topAnchor.constraint(equalTo: bookISBN.bottomAnchor, constant: 12),
            classLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            classLabel.widthAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            bookClass.topAnchor.constraint(equalTo: bookISBN.bottomAnchor, constant: 12),
            bookClass.leadingAnchor.constraint(equalTo: classLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sellerLabel.topAnchor.constraint(equalTo: addButton.topAnchor, constant: -100),
            sellerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            sellerImage.topAnchor.constraint(equalTo: sellerLabel.bottomAnchor, constant: 5),
            sellerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            sellerImage.widthAnchor.constraint(equalToConstant: 50),
            sellerImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            sellerName.topAnchor.constraint(equalTo: sellerImage.topAnchor),
            sellerName.leadingAnchor.constraint(equalTo: sellerImage.trailingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            sellerEmail.topAnchor.constraint(equalTo: sellerName.bottomAnchor),
            sellerEmail.leadingAnchor.constraint(equalTo: sellerName.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 364),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func configure(inputBookData:Book){
        if inputBookData.image.count == 0 {
            bookImage.image = UIImage(named: "default_book")
        }
        else{
            bookImage.sd_setImage(with: URL(string: inputBookData.image[0].url), placeholderImage: UIImage(named: "default_book"))
        }
        
        //      bookImage.image = UIImage(named: inputBookData.image)
        bookTitle.text = inputBookData.title
        bookAuthor.text = inputBookData.author
        let price = (inputBookData.price as NSString).floatValue
        bookPrice.text = "$\(String(format: "%.2f", price))"
        bookEdition.text = "Edition: \(inputBookData.edition)"
        bookISBN.text = "ISBN: \(inputBookData.isbn)"
        bookClass.text = inputBookData.courseName
        bookCondition.text = inputBookData.condition
        
        //get seller name and email
        NetworkManager.getUserInfo(currentUserId: inputBookData.sellerId){ [self] responseData in
            self.sellerEmail.text = responseData.email
            self.sellerName.text = responseData.name
            self.seller = UserInfo(id: responseData.id, email: responseData.email, name: responseData.name)
            
        }
        
        let userID :Int = NetworkManager.currentUser.id
        NetworkManager.getUserInfo(currentUserId: userID){ responseData in
            
            if responseData.cart.contains(inputBookData){
                self.saved.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            else{
                self.saved.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
            self.buyer = UserInfo(id: responseData.id, email: responseData.email, name: responseData.name)
        }
        
        bookID = inputBookData.id
        book = inputBookData
    }
    
    //    @objc func addButtonTapped()
    //    {
    //MARK: Keep for cart feature
    //        let userID :Int = LoginViewController.currentUser.id
    //        let postStruct = addCartStruct(bookId: bookID)
    //        let updateToken:String = LoginViewController.currentUser.update_token
    //
    //
    //        if addButton.titleLabel?.text == "Add to Cart"{
    //            //add to cart
    //            NetworkManager.addToCart(book: postStruct, currentUserId: userID,updateToken: updateToken){
    //                books in
    //                let alert = UIAlertController(title: "Success", message: "added to cart!", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
    //                self.addButton.setTitle("Remove from Cart", for: .normal)
    //            }
    //        }
    //        else{
    //            //remove from cart
    //            NetworkManager.deleteOneBookFromCart(currentUserId: userID, bookId: bookID,updateToken: updateToken){ books in //returned cart is not used
    //                let alert = UIAlertController(title: "Success", message: "removed from cart!", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: nil))
    //                self.addButton.setTitle("Add to Cart", for: .normal)
    //            }
    //        }
    //    }
    
    @objc func addButtonTapped(){
        FirebaseService.getChat(buyer: buyer, seller: seller, book: book) { messages in
            self.chatDelegate?.showChat(inputBook: self.book, buyer: self.buyer, seller: self.seller, messages: messages)
        }
    }
    
    @objc func saveButtonTapped(){
        let userID :Int = NetworkManager.currentUser.id
        let postStruct = addCartStruct(bookId: bookID)
        let updateToken:String = NetworkManager.currentUser.update_token
        
        if !isSaved {
            //add to saved
            NetworkManager.addToCart(book: postStruct, currentUserId: userID,updateToken: updateToken){
                books in
                self.saved.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
        }
        else{
            //remove from saved
            NetworkManager.deleteOneBookFromCart(currentUserId: userID, bookId: bookID,updateToken: updateToken){ books in //returned cart is not used
                self.saved.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
        }
        
        isSaved.toggle()
    }
}
