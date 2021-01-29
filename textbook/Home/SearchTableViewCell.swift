//
//  SearchTableViewCell.swift
//  textbook
//
//  Created by Jessica Wu on 12/11/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

protocol SearchShowProductInfoProtocol: class {
    func showProductInfoFromSearch(inputBook:Book)
}

class SearchTableViewCell: UITableViewCell {
    
    let aqua: UIColor = UIColor(red: 0.168, green: 0.543, blue: 0.567, alpha: 1)
    
    var bookTitle: UILabel!
    var bookPrice: UILabel!
    var bookAuthor: UILabel!
    var bookEdition: UILabel!
    var bookISBN: UILabel!
    var bookImage: UIImageView!
    var listingButton: UIButton!
    
    var book = Book(id: -1, image: [], title: "", author: "", courseName: "", isbn: "", edition: "", price: "", available: false, createdAt: "", updatedAt: "", sellerId: -1, condition: "")
    
    weak var productInfoDelegate: SearchShowProductInfoProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        bookTitle = UILabel()
        bookTitle.textColor = .black
        bookTitle.font = .boldSystemFont(ofSize: 17)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookTitle)
        
        bookPrice = UILabel()
        bookPrice.textColor = .lightGray
        bookPrice.font = .systemFont(ofSize: 15)
        bookPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookPrice)
        
        bookAuthor = UILabel()
        bookAuthor.textColor = .lightGray
        bookAuthor.font = .systemFont(ofSize: 15)
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookAuthor)
        
        bookEdition = UILabel()
        bookEdition.textColor = .lightGray
        bookEdition.font = .systemFont(ofSize: 15)
        bookEdition.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookEdition)
        
        bookISBN = UILabel()
        bookISBN.textColor = .lightGray
        bookISBN.font = .systemFont(ofSize: 15)
        bookISBN.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookISBN)
        
        bookImage = UIImageView()
        bookImage.contentMode = .scaleAspectFit
        bookImage.layer.cornerRadius = 7
        bookImage.clipsToBounds = true
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookImage)
        
        listingButton = UIButton()
        listingButton.layer.cornerRadius = 13
        listingButton.clipsToBounds = true
        listingButton.setTitle("See Listing", for: .normal)
        listingButton.setTitleColor(.white, for: .normal)
        listingButton.backgroundColor = aqua
        listingButton.translatesAutoresizingMaskIntoConstraints = false
        listingButton.addTarget(self, action: #selector(listingButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(listingButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: 112)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            bookTitle.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor,constant: padding),
            bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            bookPrice.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor,constant: padding),
            bookPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 20),
            bookAuthor.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor,constant: padding),
            bookAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookEdition.topAnchor.constraint(equalTo: bookAuthor.bottomAnchor),
            bookEdition.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor,constant: padding),
            bookEdition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookISBN.topAnchor.constraint(equalTo: bookEdition.bottomAnchor),
            bookISBN.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor,constant: padding),
            bookISBN.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            listingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            listingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listingButton.widthAnchor.constraint(equalToConstant: 110),
            listingButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    func configure(inputBookData:Book) {
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
        //        bookClass.text = inputBookData.courseName
        //        bookCondition.text = inputBookData.condition
        
        book = inputBookData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func listingButtonTapped(){
        productInfoDelegate?.showProductInfoFromSearch(inputBook: book)
    }
    
}

